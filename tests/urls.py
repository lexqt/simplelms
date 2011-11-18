from django.conf.urls.defaults import patterns, url
from .views import DebugFrameView, TestView

urlpatterns = patterns('tests.views',
    url(r'^start/(?P<course_id>\d+)/(?P<test_id>\d+)$', TestView.as_view(), {'start': True}, name='start_test'),
    url(r'^run/(?P<course_id>\d+)/(?P<scheme>\d+)/(?P<script_id>\d+)$', TestView.as_view(), name='run_test'),
    url(r'^finish/(?P<course_id>\d+)/(?P<scheme>\d+)/(?P<script_id>\d+)$', TestView.as_view(), {'finish': True}, name='finish_test'),
    url(r'^debugframe/(?P<scheme>\d+)/(?P<frame_id>\d+)$', DebugFrameView.as_view(), name='debug_frame'),
)
