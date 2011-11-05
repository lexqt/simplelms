# coding: utf-8

from django.contrib import admin
from django.db import models
from .models import Lection, LectionPage, LectionResult
from tinymce.widgets import TinyMCE
from common.admin import LinkedStackedInline
from django.conf import settings



class LectionPageInline(LinkedStackedInline):
    model = LectionPage
    
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

    

class LectionAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    list_display       = ('id', 'title')
    list_display_links = ('id', 'title')
    search_fields      =       ('title',)
    list_per_page = 20
    
    
    inlines = (LectionPageInline,)



class LectionPageAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    fieldsets = (
        (None, {
            'fields': (('num', 'title'), 'content')
        }),
    )
    list_display       = ('id', 'lection', 'num', 'title')
    list_display_links = ('id',                  'title')
    list_editable      =                 ('num',)
    list_filter        =       ('lection',)
    search_fields      = ('title', 'lection__title',)
    ordering = ('lection', 'num')
    list_per_page = 20
    



admin.site.register(Lection, LectionAdmin)
admin.site.register(LectionPage, LectionPageAdmin)

if settings.DEBUG:
    admin.site.register(LectionResult, admin.ModelAdmin)
