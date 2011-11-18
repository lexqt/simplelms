from django.conf.urls.defaults import patterns, url
from .views import LectureView, finish_lecture_view

urlpatterns = patterns('lectures.views',
    url(r'^view/(?P<course_id>\d+)/(?P<lecture_id>\d+)$', LectureView.as_view(), {'overview': True}, name='lecture_view'),
    url(r'^view/(?P<course_id>\d+)/(?P<lecture_id>\d+)/(?P<page>\d+)$', LectureView.as_view(), {'overview': False}, name='lecture_view'),
    url(r'^finish/(?P<course_id>\d+)/(?P<lecture_id>\d+)$', finish_lecture_view, name='lecture_finish'),
)
