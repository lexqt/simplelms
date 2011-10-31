from django.conf.urls.defaults import patterns, url
from .views import CourseListView, MyCoursesListView, ApplicationsOverviewListView, CourseApplicationsListView

urlpatterns = patterns('courses.views',
    url(r'^list$', CourseListView.as_view(), name='list'),
    url(r'^mycourses$', MyCoursesListView.as_view(), name='my_courses'),
    url(r'^submitapp/(\d+)$', 'submit_application_view', name='submit_app'),
    url(r'^appsoverview$', ApplicationsOverviewListView.as_view(), name='apps_overview'),
    url(r'^courseapps/(?P<course_id>\d+)$', CourseApplicationsListView.as_view(), name='course_apps'),
    url(r'^submitapp/(?P<app_id>\d+)/(?P<accept>\d+)$', 'accept_application_view', name='accept_app'),
)
