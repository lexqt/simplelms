# coding: utf-8

from django.views.generic import DetailView, TemplateView
from .models import Lection, LectionResult
from django.contrib.auth.decorators import login_required
from django.utils.decorators import method_decorator
from courses.models import Course
from django.shortcuts import get_object_or_404
from django.core.paginator import Paginator, InvalidPage
from django.http import Http404
from django.shortcuts import render

class LectionView(DetailView):

    context_object_name = 'lection'

    def get_object(self):
        self.course = Course.get_or_fail(self.kwargs['course_id'], user=self.request.user,
                                             check_student=True)
        
        if self.kwargs['overview']:
            self.lection = get_object_or_404(Lection, id=self.kwargs['lection_id'])
            self.pages = self.lection.pages.only('title')
        else:
            self.lection = get_object_or_404(Lection.objects.only('title'), id=self.kwargs['lection_id'])
            if not self.lection.in_course(self.course):
                raise Http404('Запрошенная лекция отсутствует в составе курса')
            
            paginator = Paginator(self.lection.pages.all(), 1)
            self.paginator = paginator
            cur_page_num = self.kwargs['page']
            try:
                self.page = paginator.page(cur_page_num)
            except InvalidPage:
                raise Http404('Запрошенный номер страницы отсутствует')
            
        return self.lection
    
    def get_template_names(self):
        if self.kwargs['overview']:
            return 'lection_view_overview.html'
        else:
            return 'lection_view_page.html'

    @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(LectionView, self).dispatch(*args, **kwargs)

    def get_context_data(self, **kwargs):
        context = super(LectionView, self).get_context_data(**kwargs)

        context['course'] = self.course
        context['lection'] = self.lection
        if self.kwargs['overview']:
            context['lection_pages'] = self.pages
        else:
            context['page'] = self.page
            context['lection_page'] = self.page.object_list[0]
            context['page_cnt'] = self.paginator.num_pages
        return context



@login_required
def finish_lection_view(request, course_id, lection_id):
    course = Course.get_or_fail(course_id, user=request.user, check_student=True,
                                queryset=Course.objects.only('id'))
    lection = get_object_or_404(Lection.objects.only('title'), id=lection_id)
    if not lection.in_course(course):
        raise Http404('Запрошенная лекция отсутствует в составе курса')
    
    LectionResult.pass_lection(lection, course, request.user)
    
    return render(request, 'lection_finished.html', {'course': course, 'lection': lection})
