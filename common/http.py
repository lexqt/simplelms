# coding: utf-8

# Http403* classes from http://chronosbox.org/blog/manipulando-erros-http-403-permissao-negada-no-django?lang=en

from django.conf import settings
from django.http import HttpResponseForbidden
from django.template import RequestContext, Template, loader, TemplateDoesNotExist
from django.utils.importlib import import_module

"""
# This is exception for one Http403 response, 403 code is HttpForbidden, django
# provide a HttpResponseForbidden class, but isn't handled as Http404
# exception, this code is write to make it functional.
"""

class Http403(Exception):
    """Exception for Http Forbidden"""

class Http403Middleware(object):
    """
    Replace Http403 raises for a 403.html rendered template
    """
    def process_exception(self, request, exception):
        """
        Render a 403.html template or a hardcoded html as denied page, but only if
        exception is instance of Http403 class
        """
        if not isinstance(exception, Http403):
            # Return None makes django reraise exception:
            return None

        try:
            # Handle import error but allow any type error from view
            callback = getattr(import_module(settings.ROOT_URLCONF), 'handler403')
            return callback(request, exception)
        except (ImportError, AttributeError):
            # doesn't exist a handler403, try get template
            try:
                t = loader.get_template('403.html')
            except TemplateDoesNotExist:
                # doesn't exist a template in path, use hardcoded template
                t = Template("""{% load i18n %}
<!DOCTYPE HTML>
<HTML>
    <HEAD>
        <TITLE>{% blocktrans with request.META.PATH as path %}You get access denied to {{ path }}.{% endblocktrans %}</TITLE>
    </HEAD>
    <BODY>
        <h2>{% trans "Access denied."%}</h2>
        <p>
        {% if message %}{{ message }}{% else %}
            {% blocktrans with request.META.PATH_INFO as path %}We're sorry, but your access are denied to the {{ path }}.{% endblocktrans %}
        {% endif %}</p>
    </BODY>
</HTML>""")

            # now use context and render template            
            c = RequestContext(request, {
                'message': exception.message
            })

            return HttpResponseForbidden(t.render(c))
