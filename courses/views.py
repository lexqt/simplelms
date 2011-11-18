# coding: utf-8

from django.views.generic import ListView, DetailView
from .models import Course, Enrollment, Application
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import HttpResponseRedirect, Http404, HttpResponse
from django.core.urlresolvers import reverse
from django.utils.decorators import method_decorator
from django.utils import simplejson as json
from django.shortcuts import render
from courses.models import Part
from django.contrib.contenttypes.models import ContentType
from django.conf import settings

class CourseListView(ListView):
    queryset = Course.objects.filter(is_active=True).order_by('-date_created')
    paginate_by = 2
    context_object_name = 'course_list'
    template_name = 'course_list.html'
    
    def get_context_data(self, **kwargs):
        context = super(CourseListView, self).get_context_data(**kwargs)
        context['next'] = self.request.get_full_path()
        return context



class CourseView(DetailView):

    template_name = 'course_view.html'
    context_object_name = 'course'

    def get_object(self):
        self.course = Course.get_or_fail(self.kwargs['course_id'], user=self.request.user, only_id=False)
        
        parts = Part.objects.filter(course=self.course).all()
        
        for part in parts:
            elements = []
            for element in part.elements.select_related('element_type').defer('element_type__name').all():
                element.num += 1
                elements.append(element)
            part.part_elements = elements
        
        self.course_parts = parts
        
        return self.course

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(CourseView, self).dispatch(*args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(CourseView, self).get_context_data(**kwargs)
        context['course'] = self.course
        context['course_parts'] = self.course_parts
        return context



class LearningCoursesListView(ListView):
    context_object_name = 'course_list'
    template_name = 'mycourses_list.html'
    
    def get_queryset(self):
        user = self.request.user
        if user.is_superuser:
            return Course.objects.filter(is_active=True).order_by('-date_created')
        return user.courses_learning.all()

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(LearningCoursesListView, self).dispatch(*args, **kwargs)



class ManagingCoursesListView(ListView):
    context_object_name = 'course_list'
    template_name = 'mycourses_list.html'
    
    def get_queryset(self):
        user = self.request.user
        if user.is_superuser:
            return Course.objects.filter(is_active=True).order_by('-date_created')
        return user.courses_managing.all()

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(ManagingCoursesListView, self).dispatch(*args, **kwargs)



class ApplicationsOverviewListView(ListView):
    context_object_name = 'course_list'
    template_name = 'apps_overview_list.html'
    
    def get_queryset(self):
        from django.db.models import Count
        queryset = self.request.user.courses_managing.only(
            'id', 'title', 'date_created').annotate(
            apps_count=Count('applications_submitted')).filter(
            apps_count__gt=0)
        return queryset

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(ApplicationsOverviewListView, self).dispatch(*args, **kwargs)



class CourseApplicationsListView(ListView):
    context_object_name = 'app_list'
    template_name = 'course_apps_list.html'
    
    def get_queryset(self):
        try:
            self.course = Course.objects.only('id', 'title').get(id=self.kwargs['course_id'])
        except Course.DoesNotExist:
            raise Http404('Курс не найден')
        
        queryset = self.course.applications_submitted.order_by('date_submitted').select_related(
            'user', 'user__userprofile').only('id', 'date_submitted',
            'user__id', 'user__last_name', 'user__first_name')
        return queryset

    def get_context_data(self, **kwargs):
        context = super(CourseApplicationsListView, self).get_context_data(**kwargs)
        context['course'] = self.course
        return context
    
    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(CourseApplicationsListView, self).dispatch(*args, **kwargs)



@login_required
def submit_application_view(request, course_id):
    class AnyError:
        pass
    
    course_id = int(course_id)
    try:
        try:
            course = Course.objects.only('id', 'title', 'is_active').get(id=course_id)
        except Course.DoesNotExist:
            messages.error(request, 'Вы пытаетесь записаться на несуществующий курс!')
            raise AnyError()
        
        if not course.is_active:
            messages.error(request, 'Вы пытаетесь записаться на неактивный курс!')
            raise AnyError()
        
        if Enrollment.has_enrollment(course, request.user):
            messages.error(request, 'Вы уже записаны на этот курс!')
            raise AnyError()
        
        if Application.has_application(course, request.user):
            messages.error(request, 'Вы уже подавали заявку на этот курс!')
            raise AnyError()
        
#        app = Application.objects.create(course=course, user=request.user)
        app = request.user.applications_submitted.create(course=course)
        messages.success(request, 'Заявка на курс <b>{}</b> подана от {}'.format(course, app.date_submitted))
    except AnyError:
        pass
    if 'next'  in request.GET:
        url = request.GET['next']
    else:
        url = reverse('courses:list')
    return HttpResponseRedirect(url)



def accept_application_view(request, app_id, accept):
    class AnyError:
        pass
    
    app_id = int(app_id)
    accept = accept == '1'
    
    msgs = []
    result = True
    
    
    try:
        perm = 'courses.accept_application' if accept else 'courses.reject_application' 
        if not request.user.has_perm(perm):
            msgs.append('У вас не хватает прав')
            raise AnyError
        
        try:
            app = Application.objects.select_related('course', 'user').only(
                'course', 'user', 'date_submitted', 'course__id', 'user__id').get(id=app_id)
        except Application.DoesNotExist:
            msgs.append('Указанная заявка не существует')
            raise AnyError
        
        if not app.course.has_course_manager(request.user):
            msgs.append('Вы не являетесь менеджером данного курса')
            raise AnyError
        
        if accept:
            enrollment, created = Enrollment.objects.get_or_create(course=app.course, user=app.user)
        
        app.delete()
        
        if accept and not created:
            msgs.append('Пользователь уже зачислен на этот курс')
            raise AnyError
        
        if accept:
            msgs.append('Пользователь зачислен на курс')
        else:
            msgs.append('Заявка отклонена')
        
    except AnyError:
        result = False
    
    
    response = {
        'result': result,
        'msgs': msgs,
    }
    
    if settings.DEBUG:
        return render(request, 'debug.html', {'content': json.dumps(response, ensure_ascii=False)})
    
    return HttpResponse(json.dumps(response, ensure_ascii=False), content_type='application/json')



    