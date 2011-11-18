# coding: utf-8

from django.contrib import admin
from django.db import models
from .models import Lecture, LecturePage, LectureResult
from tinymce.widgets import TinyMCE
from common.admin import LinkedStackedInline
from django.conf import settings



class LecturePageInline(LinkedStackedInline):
    model = LecturePage
    
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    fieldsets = (
        (None, {
            'fields': (('num', 'title'), 'content')
        }),
    )
    sortable_field_name = 'num'
    extra = 0

    

class LectureAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    list_display       = ('id', 'title')
    list_display_links = ('id', 'title')
    search_fields      =       ('title',)
    list_per_page = 20
    
    
    inlines = (LecturePageInline,)



class LecturePageAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    fieldsets = (
        (None, {
            'fields': (('num', 'title'), 'content')
        }),
    )
    list_display       = ('id', 'lecture', 'num', 'title')
    list_display_links = ('id',                   'title')
    list_editable      =                  ('num',)
    list_filter        =       ('lecture',)
    search_fields      = ('title', 'lecture__title',)
    ordering = ('lecture', 'num')
    list_per_page = 20
    



admin.site.register(Lecture, LectureAdmin)
admin.site.register(LecturePage, LecturePageAdmin)

if settings.DEBUG:
    admin.site.register(LectureResult, admin.ModelAdmin)
