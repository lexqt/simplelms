# coding: utf-8

from django.contrib import admin
from django.db import models
from .models import Lecture, LecturePage, LectureResult
from tinymce.widgets import TinyMCE
from common.admin import LinkedStackedInline
from django.contrib.auth.models import User
from courses.models import Course



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
    
    def get_readonly_fields(self, request, obj=None):
        if request.user.is_superuser:
            return super(LecturePageInline, self).get_readonly_fields(request, obj)
        
        if obj is None:
            return tuple()
        else:
            if request.user in obj.authors.all():
                return tuple()
            else:
                return ('title', 'content')
    

    

class LectureAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    list_display       = ('id', 'title')
    list_display_links = ('id', 'title')
    search_fields      =       ('title',)
    list_per_page = 20
    
    inlines = (LecturePageInline,)
    
    def get_readonly_fields(self, request, obj=None):
        if request.user.is_superuser:
            return super(LectureAdmin, self).get_readonly_fields(request, obj)
        
        if obj is None:
            return tuple()
        else:
            if request.user in obj.authors.all():
                return ('authors',)
            else:
                return ('title', 'description', 'authors', 'courses_allowed')
    
    def queryset(self, request):
        if request.user.is_superuser:
            qs = Lecture.objects.all()
        else:
#            qs = request.user.lectures_created
            courses = request.user.courses_managing.all()
            qs = Lecture.objects.filter(courses_allowed__in=courses).distinct()
        return qs.defer('description')

    def formfield_for_manytomany(self, db_field, request, **kwargs):
        if db_field.name == 'authors':
            kwargs['queryset'] = User.objects.filter(groups__name__in=('managers',), is_active=True).only('username')
        elif db_field.name == 'courses_allowed':
            kwargs['queryset'] = Course.objects.filter(is_active=True).only('title')
        return super(LectureAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)



class LecturePageAdmin(admin.ModelAdmin):
    
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    fieldsets = (
        (None, {
            'fields': ('lecture', ('num', 'title'), 'content')
        }),
    )
    list_display       = ('id', 'lecture', 'num', 'title')
    list_display_links = ('id',                   'title')
    list_editable      =                  ('num',)
#    list_filter        =       ('lecture',)
    search_fields      = ('title', 'lecture__title',)
    ordering = ('lecture', 'num')
    list_per_page = 20
    
    raw_id_fields = ('lecture',)

    related_lookup_fields = {
        'fk': ['lecture'],
    }

    
    def get_readonly_fields(self, request, obj=None):
        if request.user.is_superuser:
            return super(LecturePageAdmin, self).get_readonly_fields(request, obj)
        
        if obj is None:
            return tuple()
        else:
            if request.user in obj.lecture.authors.all():
                return ('lecture',)
            else:
                return ('lecture', 'title', 'content', 'num')
    
    def has_change_permission(self, request, obj=None):
        if request.user.is_superuser:
            return super(LecturePageAdmin, self).has_change_permission(request, obj)
        if obj is None:
            return False
        else:
            if not super(LecturePageAdmin, self).has_change_permission(request, obj):
                return False
            else:
                return request.user in obj.lecture.authors.all()
    
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == 'lecture':
            kwargs['queryset'] = request.user.lectures_created.all().only('title')
        return super(LecturePageAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)



class LectureResultAdmin(admin.ModelAdmin):
    
    list_display       = ('id', 'course', 'lecture', 'user', 'is_passed')
    list_display_links = ('id',)
    list_filter        =       ('course',)
    search_fields      = ('lecture__title',)
    
    ordering = ('course', 'lecture', 'user')
    list_per_page = 20
    
    raw_id_fields = ('course', 'lecture', 'user')

    related_lookup_fields = {
        'fk': ['course', 'lecture', 'user'],
    }

    
    def get_readonly_fields(self, request, obj=None):
        if request.user.is_superuser:
            return super(LectureResultAdmin, self).get_readonly_fields(request, obj)
        
        if obj is None:
            return tuple()
        else:
            return ('course', 'lecture', 'user', 'is_passed')



admin.site.register(Lecture, LectureAdmin)
admin.site.register(LecturePage, LecturePageAdmin)
admin.site.register(LectureResult, LectureResultAdmin)
