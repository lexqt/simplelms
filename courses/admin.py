# coding: utf-8

from django.contrib import admin
from django.db import models
from django.db.models import Q
from .models import Course, Part, Element, Application, Enrollment, Certificate
from tinymce.widgets import TinyMCE
from django.contrib.auth.models import Group
from common.admin import LinkedStackedInline
from django.contrib.contenttypes.models import ContentType



class CoursePartInline(LinkedStackedInline):
    model = Part
    
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    fieldsets = (
        (None, {
            'fields': (('num', 'title'), 'description')
        }),
    )
    sortable_field_name = 'num'
    extra = 0

    

class CourseAdmin(admin.ModelAdmin):
    date_hierarchy = 'date_created'
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    list_display       = ('id', 'title', 'is_active', 'date_created')
    list_display_links = ('id', 'title')
    list_editable      =                ('is_active',)
    list_filter        =                ('is_active', 'date_created')
    search_fields      =        ('title',)
    ordering = ('date_created',)
    list_per_page = 20
    
    exclude = ('students',)
    
    inlines = (CoursePartInline,)

    def formfield_for_manytomany(self, db_field, request, **kwargs):
        if db_field.name == 'managers':
            kwargs['queryset'] = Group.objects.get(name='managers').user_set.filter(is_active=True).only('username')
        return super(CourseAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)



class ApplicationAdmin(admin.ModelAdmin):
    #TODO: actions 'accept', 'reject'
    date_hierarchy = 'date_submitted'
    list_display       = ('id', 'date_submitted', 'course', 'user')
    list_display_links = ('id', 'date_submitted')
    list_filter        =       ('date_submitted', 'course')
    search_fields      =                         ('course__title',)
    ordering = ('date_submitted', 'course')
    list_per_page = 10
    readonly_fields = ('date_submitted', 'course', 'user')
    
    def queryset(self, request):
        qs = super(ApplicationAdmin, self).queryset(request)
        if request.user.is_superuser:
            return qs
        courses = request.user.courses_managing.only('id')
        return qs.filter(course__in=courses)



class EnrollmentAdmin(admin.ModelAdmin):
    date_hierarchy = 'date_enrolled'
    list_display       = ('id', 'date_enrolled', 'course', 'user')
    list_display_links = ('id', 'date_enrolled')
    list_filter        =       ('date_enrolled', 'course')
    search_fields      =                                  ('user__username',)
    ordering = ('date_enrolled', 'course')
    list_per_page = 10
    raw_id_fields = ('user',)

    related_lookup_fields = {
        'fk': ['user',],
    }

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == 'course':
            u = request.user
            q = u.courses_managing.all() if not u.is_superuser else Course.objects.all()
            kwargs['queryset'] = q.filter(is_active=True)
        return super(EnrollmentAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)
    
#    def has_change_permission(self, request, obj=None):
#        if super(EnrollmentAdmin, self).has_change_permission(request, obj):
#            if obj is None:
#                return True
#        return False
    
    def get_readonly_fields(self, request, obj=None):
        if obj is None:
            return tuple()
        else:
            return ('date_enrolled', 'course', 'user')
    
    def queryset(self, request):
        qs = super(EnrollmentAdmin, self).queryset(request)
        if request.user.is_superuser:
            return qs
        courses = request.user.courses_managing.only('id')
        return qs.filter(course__in=courses)
    
    # оказалось, что все это не нужно.
    # ограничивающего queryset (см. ранее formfield_for_foreignkey) достаточно
    
#    form = EnrollmentAdminForm

#    def get_form(self, request, obj=None, **kwargs):
#        form = super(EnrollmentAdmin, self).get_form(request, obj, **kwargs)
#        form.current_user = request.user
#        return form



class CourseElementInline(LinkedStackedInline):
    model = Element
    
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    fieldsets = (
        (None, {
            'fields': (('num', 'title'), 'description', 'max_rating', 'element_type', 'object_id')
        }),
    )
    sortable_field_name = 'num'
    extra = 0
   
    related_lookup_fields = {
        'generic': [['element_type', 'object_id'],],
    }

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == 'element_type':
            kwargs['queryset'] = ContentType.objects.filter(Q(app_label='lections') & Q(model='lection'))
        return super(CourseElementInline, self).formfield_for_foreignkey(db_field, request, **kwargs)


class CoursePartAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    list_display       = ('id', 'course', 'num', 'title')
    list_display_links = ('id',                  'title')
    list_editable      =                 ('num',)
    list_filter        =       ('course',)
    search_fields      =       ('course__title',)
    ordering = ('course', 'num')
    list_per_page = 20
    
    inlines = (CourseElementInline,)



class CourseElementAdmin(admin.ModelAdmin):
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    fieldsets = (
        (None, {
            'fields': (('num', 'title'), 'description', 'max_rating', 'element_type', 'object_id')
        }),
    )
    
    related_lookup_fields = {
        'generic': [['element_type', 'object_id'],],
    }

    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        if db_field.name == 'element_type':
            kwargs['queryset'] = ContentType.objects.filter(Q(app_label='lections') & Q(model='lection'))
        return super(CourseElementInline, self).formfield_for_foreignkey(db_field, request, **kwargs)



admin.site.register(Course, CourseAdmin)
admin.site.register(Part, CoursePartAdmin)
admin.site.register(Element, CourseElementAdmin)
admin.site.register(Application, ApplicationAdmin)
admin.site.register(Enrollment, EnrollmentAdmin)
admin.site.register(Certificate, admin.ModelAdmin)
