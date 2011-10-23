from django.conf.urls.defaults import patterns, url

urlpatterns = patterns('accounts.views',
    url(r'^login$', 'login_view', name='login'),
    url(r'^logout$', 'logout_view', name='logout'),
    url(r'^register$', 'register_view', name='register'),
)
