from django.conf.urls.defaults import patterns, url
from .views import UserResultsView, CourseResultsView

urlpatterns = patterns('monitoring.views',
    url(r'^user-results/(?P<user_id>\d+)/(?P<course_id>\d+)$', UserResultsView.as_view(), name='user_results'),
    url(r'^course-results/(?P<course_id>\d+)$', CourseResultsView.as_view(), name='course_results'),
)
