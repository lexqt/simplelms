# coding: utf-8

from django.contrib import admin
from django.db import models
from common.admin import LinkedStackedInline
from .models import TestFrame, Test, Session, TestResult
from django.conf import settings



admin.site.register(TestFrame, admin.ModelAdmin)
admin.site.register(Test, admin.ModelAdmin)
admin.site.register(Session, admin.ModelAdmin)
admin.site.register(TestResult, admin.ModelAdmin)


if settings.DEBUG:
    from .models import SessionFrame
    admin.site.register(SessionFrame, admin.ModelAdmin)
