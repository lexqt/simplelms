# coding: utf-8

from django.views.generic import ListView, DetailView
from courses.models import Course
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from django.shortcuts import get_object_or_404
from courses.models import Part
from django.contrib.auth.models import User
from common.http import Http403
from lectures.models import LectureResult
from tests.models import TestResult
from decimal import Decimal



class UserResultsView(DetailView):

    template_name = 'user_results.html'

    def get_object(self):
        from collections import defaultdict
        
        parts = Part.objects.filter(course=self.course).defer('description').all()
        
        qs = LectureResult.objects.select_related('lecture').filter(
                                    course=self.course, user=self.user_mon).defer('lecture__description')
        lecture_results = defaultdict(Decimal)
        for res in qs:
            lecture_results[res.lecture.id] = Decimal(res.is_passed)
        
        raw = '''SELECT tests_testresult.id,
                        tests_test.id AS test_id,
                        tests_testresult.scheme,
                        tests_testresult.script_id,
                        tests_testresult.rating,
                        tests_testresult.is_passed,
                        MAX(tests_testresult.try_number) AS last_try
                FROM tests_testresult, tests_test
                WHERE (tests_test.scheme=tests_testresult.scheme AND
                       tests_test.script_id=tests_testresult.script_id AND
                       tests_testresult.course_id = %s AND
                       tests_testresult.user_id = %s )
                GROUP BY tests_testresult.course_id,
                         tests_testresult.user_id,
                         tests_testresult.scheme,
                         tests_testresult.script_id
                ORDER BY tests_testresult.scheme ASC, tests_testresult.script_id ASC,
                         tests_testresult.try_number ASC'''
#        qs = TestResult.objects.extra(
#                select={'test_id': 'tests_test.id'},
#                where=['tests_test.scheme=tests_testresult.scheme AND tests_test.script_id=tests_testresult.script_id'],
#                tables=['tests_test']).values(
#                'course', 'user', 'test_id').annotate(
#                last_try=Max('try_number')).filter(
#                course=self.course, user=self.user_mon).values(
#                'test_id', 'scheme', 'script_id', 'last_try', 'rating', 'is_passed')
        qs = TestResult.objects.raw(raw, (self.course.id, self.user_mon.id))
        test_results = defaultdict(Decimal)
        for res in qs:
            test_results[res.test_id] = Decimal(res.is_passed) * res.rating
        
        for part in parts:
            part.num += 1
            elements = []
            for element in part.elements.select_related('element_type').defer(
                                        'description', 'element_type__name').all():
                element.num += 1
                oid  = element.object_id
                t    = element.element_type.model
                rmax = element.max_rating
                if   t == 'lecture':
                    rating = lecture_results[oid] * rmax
                elif t == 'test':
                    rating = test_results[oid] / 100 * rmax
                else:
                    # unsupported type
                    rating = 0.0
                element.cur_rating = rating
                elements.append(element)
            part.part_elements = elements
        
        self.course_parts = parts
        
        return self.course

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        request = args[0]
        user = request.user
        
        self.is_self_mon = user.id == int(kwargs['user_id'])
        if self.is_self_mon:
            self.user_mon = user
        else:
            self.user_mon = get_object_or_404(User, id=kwargs['user_id'])

        self.course = Course.get_or_fail(kwargs['course_id'], user=self.user_mon, check_manager=False, only_id=False)
        
        if not user.is_superuser and not self.is_self_mon and not self.course.has_course_manager(user):
            raise Http403('Вы не можете просматривать результаты по курсам, управляющими которых не являетесь')
        
        return super(UserResultsView, self).dispatch(*args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(UserResultsView, self).get_context_data(**kwargs)
        context['user']         = self.user_mon
        context['course']       = self.course
        context['course_parts'] = self.course_parts
        return context



class CourseResultsView(ListView):
    context_object_name = 'course_list'
    template_name = 'course_results.html'
    
    def get_queryset(self):
        user = self.request.user
        
        self.course = Course.get_or_fail(self.kwargs['course_id'], user=user, check_student=False, only_id=False)
        self.users  = self.course.students.select_related('profile').order_by('last_name', 'first_name', 'profile__middle_name')
        
        return self.users

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(CourseResultsView, self).dispatch(*args, **kwargs)
    
    def get_context_data(self, **kwargs):
        context = super(CourseResultsView, self).get_context_data(**kwargs)
        context['users']  = self.users
        context['course'] = self.course
        return context

    