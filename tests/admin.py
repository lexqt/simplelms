# coding: utf-8

from django.contrib import admin
from django.db import models
from common.admin import LinkedStackedInline
from .models import TestFrame



admin.site.register(TestFrame, admin.ModelAdmin)
