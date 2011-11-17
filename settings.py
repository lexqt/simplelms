# encoding: utf-8
# Django settings for simplelms project.

DEBUG = False
TEMPLATE_DEBUG = DEBUG

import os
CURRENT_APP_DIR = os.path.dirname(__file__)


ADMINS = (
    # ('Your Name', 'your_email@example.com'),
)

MANAGERS = ADMINS

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql', # Add 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'oracle'.
        'NAME': 'simplelms',                      # Or path to database file if using sqlite3.
        'USER': 'lms',                      # Not used with sqlite3.
        'PASSWORD': 'lms',                  # Not used with sqlite3.
        'HOST': '',                      # Set to empty string for localhost. Not used with sqlite3.
        'PORT': '',                      # Set to empty string for default. Not used with sqlite3.
    }
}

# Local time zone for this installation. Choices can be found here:
# http://en.wikipedia.org/wiki/List_of_tz_zones_by_name
# although not all choices may be available on all operating systems.
# On Unix systems, a value of None will cause Django to use the same
# timezone as the operating system.
# If running in a Windows environment this must be set to the same as your
# system time zone.
TIME_ZONE = 'Europe/Moscow'

# Language code for this installation. All choices can be found here:
# http://www.i18nguy.com/unicode/language-identifiers.html
LANGUAGE_CODE = 'ru-ru'

SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = True

# If you set this to False, Django will not format dates, numbers and
# calendars according to the current locale
USE_L10N = True

# Absolute filesystem path to the directory that will hold user-uploaded files.
# Example: "/home/media/media.lawrence.com/media/"
MEDIA_ROOT = '/home/lex/public_html/simplelms/media/'

# URL that handles the media served from MEDIA_ROOT. Make sure to use a
# trailing slash.
# Examples: "http://media.lawrence.com/media/", "http://example.com/media/"
MEDIA_URL = '/media/'

# Absolute path to the directory static files should be collected to.
# Don't put anything in this directory yourself; store your static files
# in apps' "static/" subdirectories and in STATICFILES_DIRS.
# Example: "/home/media/media.lawrence.com/static/"
STATIC_ROOT = '/home/lex/public_html/simplelms/static/'

# URL prefix for static files.
# Example: "http://media.lawrence.com/static/"
STATIC_URL = '/static/'

# URL prefix for admin static files -- CSS, JavaScript and images.
# Make sure to use a trailing slash.
# Examples: "http://foo.com/static/admin/", "/static/admin/".
#ADMIN_MEDIA_PREFIX = '/static/admin/'
ADMIN_MEDIA_PREFIX = STATIC_URL + "grappelli/"

# Additional locations of static files
STATICFILES_DIRS = (
    # Put strings here, like "/home/html/static" or "C:/www/django/static".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
#    '/home/lex/Projects/simplelms/static/',
    os.path.join(CURRENT_APP_DIR, 'static'),
)

# List of finder classes that know how to find static files in
# various locations.
STATICFILES_FINDERS = (
    'django.contrib.staticfiles.finders.FileSystemFinder',
    'django.contrib.staticfiles.finders.AppDirectoriesFinder',
#    'django.contrib.staticfiles.finders.DefaultStorageFinder',
)

# Make this unique, and don't share it with anybody.
SECRET_KEY = '-l6xbt+41e1%yyoblos$clmqpw^9dgs%j)v%y+9ojr%5b3c(g4'

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
#     'django.template.loaders.eggs.Loader',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'common.http.Http403Middleware',
)

ROOT_URLCONF = 'simplelms.urls'

TEMPLATE_DIRS = (
    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
#    '/home/lex/Projects/simplelms/templates',
    os.path.join(CURRENT_APP_DIR, 'templates'),
)

TEMPLATE_CONTEXT_PROCESSORS = (
    'django.contrib.auth.context_processors.auth',
    'django.core.context_processors.debug',
    'django.core.context_processors.i18n',
    'django.core.context_processors.media',
    'django.core.context_processors.static',
    'django.contrib.messages.context_processors.messages',
)

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    # 'django.contrib.sites',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'grappelli',
    'filebrowser',
    # Uncomment the next line to enable the admin:
    'django.contrib.admin',
    # Uncomment the next line to enable admin documentation:
    # 'django.contrib.admindocs',
    'tinymce',
    'south',
    'news',
    'accounts',
    'courses',
    'lections',
    'tests',
)

GRAPPELLI_ADMIN_TITLE = 'Администрирование сайта'
AUTH_PROFILE_MODULE = 'accounts.UserProfile'

LOGIN_URL          = '/accounts/login'
LOGOUT_URL         = '/accounts/logout'
LOGIN_REDIRECT_URL = '/'

# A sample logging configuration. The only tangible logging
# performed by this configuration is to send an email to
# the site admins on every HTTP 500 error.
# See http://docs.djangoproject.com/en/dev/topics/logging for
# more details on how to customize your logging configuration.
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'class': 'django.utils.log.AdminEmailHandler'
        }
    },
    'loggers': {
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': True,
        },
    }
}

MESSAGE_STORAGE = 'django.contrib.messages.storage.fallback.FallbackStorage'

TINYMCE_DEFAULT_CONFIG = {
    #'mode'           : "specific_textareas",
    #'editor_selector' : "tiny_mce",
    'theme'    : "advanced",
    'language' : "ru",

    'plugins' : "advhr,advimage,advlink,advlist,contextmenu,fullscreen,inlinepopups,insertdatetime,media,nonbreaking,noneditable,paste,preview,searchreplace,style,table,visualchars",
    
    # for advimage
    'extended_valid_elements' : "img[!src|border:0|alt|title|width|height|style]a[name|href|target|title|onclick]",
    
    'plugin_preview_width' : 800,
    'plugin_preview_height' : 600,
    
    'relative_urls' : False,

    'theme_advanced_buttons1' : "fullscreen,|,undo,redo,|,bold,italic,|,styleprops,formatselect,|,bullist,numlist,|,pastetext,pasteword,|,insertdate,inserttime,|,search,replace",
    'theme_advanced_buttons2' : "link,unlink,|,image,media,|,advhr,charmap,nonbreaking,visualchars,|,tablecontrols,|,removeformat,cleanup,|,preview,code",
    'theme_advanced_buttons3' : "",

    'theme_advanced_toolbar_location' : "top",
    'theme_advanced_toolbar_align' : "left",
    'theme_advanced_statusbar_location' : "bottom",
    'theme_advanced_resizing' : False,
}
TINYMCE_SPELLCHECKER = False
TINYMCE_COMPRESSOR   = False

FILEBROWSER_DIRECTORY = ''
FILEBROWSER_URL_TINYMCE  = STATIC_URL  + 'tiny_mce/'
FILEBROWSER_PATH_TINYMCE = STATIC_ROOT + 'tiny_mce/'
FILEBROWSER_MAX_UPLOAD_SIZE = 2097152
FILEBROWSER_VERSIONS_BASEDIR = 'img_versions'
FILEBROWSER_VERSIONS = {
    'thumbnail': {'verbose_name': 'Миниатюра (квадратная)', 'width': 60, 'height': 60, 'opts': 'crop'},
    'small': {'verbose_name': 'Уменьшенное изображение', 'width': 140, 'height': '', 'opts': ''},
}
FILEBROWSER_ADMIN_THUMBNAIL = 'thumbnail'
FILEBROWSER_ADMIN_VERSIONS = ['thumbnail', 'small']

# The machine specific settings
try:
    from localsettings import *
except ImportError:
    pass
