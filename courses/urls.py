from django.conf.urls.defaults import patterns, url
from .views import CourseListView, LearningCoursesListView, ManagingCoursesListView, CourseApplicationsListView, CourseView

urlpatterns = patterns('courses.views',
    url(r'^list$', CourseListView.as_view(), name='list'),
    url(r'^learning$', LearningCoursesListView.as_view(), name='learning_courses'),
    url(r'^managing$', ManagingCoursesListView.as_view(), name='managing_courses'),
    url(r'^submitapp/(\d+)$', 'submit_application_view', name='submit_app'),
#    url(r'^appsoverview$', ApplicationsOverviewListView.as_view(), name='apps_overview'),
    url(r'^courseapps/(?P<course_id>\d+)$', CourseApplicationsListView.as_view(), name='course_apps'),
#    url(r'^acceptapp/(?P<app_id>\d+)/(?P<accept>\d+)$', 'accept_application_view', name='accept_app'),
    url(r'^view/(?P<course_id>\d+)$', CourseView.as_view(), name='course_view'),
)
