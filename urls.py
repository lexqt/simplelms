from django.conf.urls.defaults import patterns, include, url
from filebrowser.sites import site
from news.views import FrontpageNewsView

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    url(r'^$', FrontpageNewsView.as_view(), name='home'),
    url(r'^courses/', include('courses.urls', namespace='courses', app_name='courses')),
    url(r'^accounts/', include('accounts.urls', namespace='accounts', app_name='accounts')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    url(r'^grappelli/', include('grappelli.urls')),
    url(r'^admin/filebrowser/', include(site.urls)),
    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^tinymce/', include('tinymce.urls')),
)

from django.conf import settings

if settings.DEBUG:
    urlpatterns += patterns('',
        url(r'^media/(?P<path>.*)$', 'django.views.static.serve', {
            'document_root': settings.MEDIA_ROOT,
        }),
    )
