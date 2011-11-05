from django.conf.urls.defaults import patterns, url
from .views import LectionView, finish_lection_view

urlpatterns = patterns('courses.views',
    url(r'^view/(?P<course_id>\d+)/(?P<lection_id>\d+)$', LectionView.as_view(), {'overview': True}, name='lection_view'),
    url(r'^view/(?P<course_id>\d+)/(?P<lection_id>\d+)/(?P<page>\d+)$', LectionView.as_view(), {'overview': False}, name='lection_view'),
    url(r'^finish/(?P<course_id>\d+)/(?P<lection_id>\d+)$', finish_lection_view, name='lection_finish'),
)
