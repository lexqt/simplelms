# coding: utf-8

from django.views.generic import FormView
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from .models import TestFrame, Test, SessionFrame, Session, TestResult
from .xml import TestFrameXml, FRAME_TYPE_CLASSES, TestScriptXml
from .forms import SingleCloseTypeForm, MultipleCloseTypeForm, StringOpenTypeForm
from django.core.urlresolvers import reverse
from django.shortcuts import get_object_or_404
from django.utils.functional import curry
from courses.models import Course
from django.http import Http404, HttpResponseServerError, HttpResponse,\
    HttpResponseRedirect
from django.db import transaction
import datetime
from django.shortcuts import render_to_response
from common.http import Http403



def form_class_factory(frame_type, frame):
    if frame_type == 'close':
        if frame.type.is_multiple():
            cls = MultipleCloseTypeForm
        else:
            cls = SingleCloseTypeForm
        return curry(cls, frame.type.get_answer_data())
    elif frame_type == 'open':
        t = frame.type.get_type()
        if t == 'string':
            cls = StringOpenTypeForm
        return curry(cls, frame.type.get_answer_data())
        
    raise Exception('Unsupported frame')



class DebugFrameView(FormView):
    
    template_name = 'debug_frame.html'
    
    def get_form_class(self):
        return form_class_factory(self.frame_db.frame_type, self.frame)
    
    def get_success_url(self):
        return reverse('tests:question_view')

    def get_form(self, form_class):
        return form_class(**self.get_form_kwargs())
    
    def form_valid(self, form):
#        return HttpResponseRedirect(self.get_success_url())
        return self.render_to_response(self.get_context_data(form=form, answered=True))
    
    def form_invalid(self, form):
        return self.render_to_response(self.get_context_data(form=form))
    
    def get_context_data(self, **kwargs):
        context = super(DebugFrameView, self).get_context_data(**kwargs)
        
        answered = kwargs.has_key('answered')
        if answered:
            answer = kwargs['form'].cleaned_data['answer']
            res = self.frame.type.check_answer(answer)
            context['answer_result'] = res
        
        context['answered'] = answered
        context['frame'] = self.frame
        context['frame_index'] = self.frame.frame_index
        return context
    
    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        request = args[0]
        user = request.user
        
        if not user.has_perm('tests.debug_frame') and not user.is_superuser:
            raise Http403('У Вас нет права тестировать фреймы')
        
        # TODO: restrict access to schemes
        
        self.frame_db = get_object_or_404(TestFrame, scheme=kwargs['scheme'], frame_id=kwargs['frame_id'])
        cls = FRAME_TYPE_CLASSES[self.frame_db.frame_type]
        self.frame = TestFrameXml(cls, self.frame_db.get_xml())
        return super(DebugFrameView, self).dispatch(*args, **kwargs)



class TestView(FormView):
    
    template_name = 'view_frame.html'
    
    def get_form_class(self):
        return form_class_factory(self.frame_db.frame_type, self.frame)
    
    def get_success_url(self, force_finish=False):
        kwargs={'course_id': self.course.id,
                'scheme': self.test.scheme, 'script_id': self.test.script_id}
        if not force_finish and self.session_frame.next_sframe:
            return reverse('tests:run_test', kwargs=kwargs)
        else:
            return reverse('tests:finish_test', kwargs=kwargs)

    def get_form(self, form_class):
        return form_class(**self.get_form_kwargs())
    
    def check_timeout(self):
        now = datetime.datetime.today()
        if now > self.session.date_limit:
            return HttpResponseRedirect(self.get_success_url(force_finish=True))
    
    def form_valid(self, form):
        res = self.check_timeout()
        if isinstance(res, HttpResponse):
            return res
            
        answer = form.cleaned_data['answer']
        result = self.frame.type.check_answer(answer)
        
        self.session_frame.answer    = self.frame.type.get_for_answer_store(answer)
        self.session_frame.is_passed = True
        self.session_frame.rating    = result
        self.session_frame.save()
        
        self.session.cur_session_frame  = self.session_frame.next_sframe
        self.session.num_passed        += 1
        self.session.save()
        
        return HttpResponseRedirect(self.get_success_url())
    
    def form_invalid(self, form):
        res = self.check_timeout()
        if isinstance(res, HttpResponse):
            return res
        
        return self.render_to_response(self.get_context_data(form=form))
    
    def get_context_data(self, **kwargs):
        context = super(TestView, self).get_context_data(**kwargs)
        
        show_result = not self.session.is_exam
        context['show_result'] = show_result
        if show_result:
            try:
                context['prev_result'] = self.session_frame.previous.rating > 0
            except SessionFrame.DoesNotExist:
                pass
        
        context['cnt_passed'] = self.session.num_passed
        context['date_limit'] = self.session.date_limit

        context['course'] = self.course
        context['test']   = self.test
        context['frame']  = self.frame
        return context
    
    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        request = args[0]
        self.user = request.user
        self.course = Course.get_or_fail(kwargs['course_id'], user=self.user)
        
        to_start  = kwargs.has_key('start')  and kwargs['start']
        to_finish = kwargs.has_key('finish') and kwargs['finish']
        
        if to_start:
            self.fetch_test(test_id=kwargs['test_id'])
            return self.start_test()
        else:
            self.fetch_test(scheme=kwargs['scheme'], script_id=kwargs['script_id'])
            if to_finish:
                return self.finish_test()
            else:
                self.prepare_frame()
        
        return super(TestView, self).dispatch(*args, **kwargs)
    
    def fetch_test(self, test_id=None, scheme=None, script_id=None):
        if test_id is None:
            kwargs = {'scheme': scheme, 'script_id': script_id}
        else:
            kwargs = {'id': test_id}
        self.test = get_object_or_404(Test.objects.defer('script_data'), **kwargs)
        
        if not self.test.in_course(self.course):
            raise Http404('Запрошенный тест отсутствует в составе курса')
        
    def start_test(self):
        
        # check for already opened session
        s = Session.get_opened_session(self.course, self.user)
        if s is not None:
            test = s.test
            if test is None:
                # invalid session
                s.delete()
                # TODO: better way
                return self.start_test()
            context = {
                'course': self.course,
                'test': test
            }
            return render_to_response('opened_test_session.html', context)
        
        # unpacking test script and frames
        self.script = TestScriptXml(self.test.get_xml())
        
        # check if passed
        if self.script.is_exam():
            is_passed = TestResult.check_passed(self.course, self.user, self.test.scheme, self.test.script_id)
            if is_passed:
                raise Http403('Запрещено пересдавать уже зачтенные аттестующие тесты')

        # create session
        now   = datetime.datetime.today()
        limit = now + self.script.time_limit
        self.session = Session(user=self.user, course=self.course,
                          scheme=self.test.scheme, script_id=self.test.script_id,
                          is_active=True,
                          is_exam=self.script.is_exam(),
                          rating_threshold=self.script.rating_threshold,
                          date_started=now,
                          date_limit=limit)
        self.session.save(force_insert=True)
        
        # unpacking test frames
        frames = self.script.get_frames()
        res = self._prepare_session_frames(frames)
        if isinstance(res, HttpResponse):
            self.session.delete()
            return res
        
        # update session
        self.session.cur_session_frame = self.first_session_frame
        self.session.save(force_update=True)
        
        # render start frame
        context = {
            'course': self.course,
            'script': self.script,
            'date_limit': self.session.date_limit
        }
        return render_to_response('start_test_session.html', context)
    
    @transaction.commit_manually
    def _prepare_session_frames(self, frames):
        frames = frames.values()
        next_sf = None
        for frame in reversed(frames):
            idx = frame['index']
            w   = frame['weight']
            try:
                tf = TestFrame.objects.only('scheme', 'frame_id').get(scheme=idx.scheme, frame_id=idx.frame_id)
            except TestFrame.DoesNotExist:
                transaction.rollback()
                return HttpResponseServerError('В БД отсутствуют фреймы, указанные в сценарии теста')
            sf = SessionFrame(scheme=tf.scheme, frame_id=tf.frame_id, weight=w, session=self.session)
            sf.next_sframe = next_sf
            next_sf = sf
            sf.save(force_insert=True)
        
        self.first_session_frame = sf
        transaction.commit()
    
    def finish_test(self):
        s = Session.get_opened_session(self.course, self.user, self.test.scheme, self.test.script_id)
        if s is None:
            raise Http404('Нет открытой сессии для данного теста')
        
        now = datetime.datetime.today()
        s.date_ended = now
        
        s.is_active   = False
        s.is_finished = True
        
        s.cur_session_frame = None
        
        s.save()
        
        stats = s.get_test_stats()
        
        try_number = TestResult.get_next_try_number(self.course, self.user, self.test.scheme, self.test.script_id)
        rating     = stats['rating']['got']
        is_passed  = rating >= s.rating_threshold
        new_result = TestResult(course=self.course, user=self.user,
                                scheme=self.test.scheme, script_id=self.test.script_id,
                                session=s,
                                rating=rating, is_passed=is_passed, try_number=try_number)
        new_result.save(force_insert=True)
        
        context = dict(test=self.test, course=self.course, is_passed=is_passed)
        context.update(stats)
        
        now = datetime.datetime.today()
        if now > s.date_limit:
            context['message'] = 'Время, отведенное на тестирование, вышло.'
        
        # workaround bug in floatformat
        context['rating']['got'] = '%.2f' % rating
        
        return render_to_response('finish_test_session.html', context)
    
    def prepare_frame(self):
        s = Session.get_opened_session(self.course, self.user, self.test.scheme, self.test.script_id)
        if s is None:
            raise Http404('Нет открытой сессии для данного теста')
        self.session = s
        
        sframe = s.cur_session_frame
        if sframe is None:
            s.delete()
            raise Http404('Не установлен текущий фрейм для сессии. Открытая сессия и результаты удалены.')
        
        self.session_frame = sframe
        
        try:
            self.frame_db = TestFrame.objects.get(scheme=sframe.scheme, frame_id=sframe.frame_id)
        except TestFrame.DoesNotExist:
            s.delete()
            raise Http404('Невозможно получить сценарий текущего фрейма сессии. Открытая сессия и результаты удалены.')

        cls = FRAME_TYPE_CLASSES[self.frame_db.frame_type]
        self.frame = TestFrameXml(cls, self.frame_db.get_xml())

