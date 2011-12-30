# coding: utf-8

from django.views.generic import DetailView, TemplateView
from .models import Lecture, LectureResult
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from courses.models import Course
from django.shortcuts import get_object_or_404
from django.core.paginator import Paginator, InvalidPage
from django.http import Http404
from django.shortcuts import render

class LectureView(DetailView):

    context_object_name = 'lecture'

    def get_object(self):
        self.course = Course.get_or_fail(self.kwargs['course_id'], user=self.request.user)
        
        if self.kwargs['overview']:
            self.lecture = get_object_or_404(Lecture, id=self.kwargs['lecture_id'])
            self.pages = self.lecture.pages.only('title')
            
            for page in self.pages:
                page.num += 1
            
        else:
            self.lecture = get_object_or_404(Lecture.objects.only('title'), id=self.kwargs['lecture_id'])
            if not self.lecture.in_course(self.course):
                raise Http404('Запрошенная лекция отсутствует в составе курса')
            
            paginator = Paginator(self.lecture.pages.all(), 1)
            self.paginator = paginator
            cur_page_num = self.kwargs['page']
            try:
                self.page = paginator.page(cur_page_num)
            except InvalidPage:
                raise Http404('Запрошенный номер страницы отсутствует')
            
        return self.lecture
    
    def get_template_names(self):
        if self.kwargs['overview']:
            return 'lecture_view_overview.html'
        else:
            return 'lecture_view_page.html'

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(LectureView, self).dispatch(*args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(LectureView, self).get_context_data(**kwargs)

        context['course'] = self.course
        context['lecture'] = self.lecture
        if self.kwargs['overview']:
            context['lecture_pages'] = self.pages
        else:
            context['page'] = self.page
            context['lecture_page'] = self.page.object_list[0]
            context['page_cnt'] = self.paginator.num_pages
        return context



@login_required
def finish_lecture_view(request, course_id, lecture_id):
    course = Course.get_or_fail(course_id, user=request.user,
                                queryset=Course.objects.only('id'))
    lecture = get_object_or_404(Lecture.objects.only('title'), id=lecture_id)
    if not lecture.in_course(course):
        raise Http404('Запрошенная лекция отсутствует в составе курса')
    
    LectureResult.pass_lecture(lecture, course, request.user)
    
    return render(request, 'lecture_finished.html', {'course': course, 'lecture': lecture})
