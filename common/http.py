# coding: utf-8

# Http403* classes from http://chronosbox.org/blog/manipulando-erros-http-403-permissao-negada-no-django?lang=en

from django.conf import settings
from django.http import HttpResponse, Http404
from django.template import RequestContext, loader
from django.utils.importlib import import_module

class Http403(Exception):
    """Exception for Http Forbidden"""

class HttpErrorsMiddleware(object):
    """Replace HttpXXX raises for a XXX.html rendered template"""

    def process_exception(self, request, exception):
        if isinstance(exception, Http403):
            code = 403
        elif isinstance(exception, Http404):
            code = 404
        else:
            # reraise exception
            return None
        
        try:
            callback = getattr(import_module(settings.ROOT_URLCONF), u'handler{0}'.format(code))
            return callback(request, exception)
        except (ImportError, AttributeError):
            pass
        
        t = loader.get_template(u'{0}.html'.format(code))

        c = RequestContext(request, {
            'request': request,
            'exception': exception
        })

        response = HttpResponse(t.render(c))
        response.status_code = code
        return response
