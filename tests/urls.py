from django.conf.urls.defaults import patterns, url
from .views import DebugFrameView

urlpatterns = patterns('tests.views',
    url(r'^debugframe/(?P<scheme>\d+)/(?P<frame_id>\d+)$', DebugFrameView.as_view(), name='debug_frame'),
)
