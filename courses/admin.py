# coding: utf-8

from django.contrib import admin
from django.db import models
from django.db.models import Q
from .models import Course, Part, Element, Application, Enrollment, Certificate
from tinymce.widgets import TinyMCE
from django.contrib.auth.models import Group, User
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
    
    def queryset(self, request):
        if request.user.is_superuser:
            qs = Course.objects.all()
        else:
            qs = request.user.courses_managing
        return qs.defer('description')

    def formfield_for_manytomany(self, db_field, request, **kwargs):
        if db_field.name == 'managers':
            kwargs['queryset'] = Group.objects.get(name='managers').user_set.filter(is_active=True).only('username')
        return super(CourseAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)
    
    def get_readonly_fields(self, request, obj=None):
        if request.user.is_superuser:
            return super(CourseAdmin, self).get_readonly_fields(request, obj)
        
        return ('managers',)



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
    
    actions = ['accept_action', 'reject_action']

    def queryset(self, request):
        qs = super(ApplicationAdmin, self).queryset(request)
        if request.user.is_superuser:
            return qs
        courses = request.user.courses_managing.only('id')
        return qs.filter(course__in=courses)
    
    def accept_action(self, request, queryset):
        for app in queryset:
            self.accept_application(request, unicode(app), app.id, accept=True)
    accept_action.short_description = u'Принять выбранные заявки'
    
    def reject_action(self, request, queryset):
        for app in queryset:
            self.accept_application(request, unicode(app), app.id, accept=False)
    reject_action.short_description = u'Отклонить выбранные заявки'
    
    def accept_application(self, request, info_title, app_id, accept):
        class AnyError:
            pass
        
        user   = request.user
        
        msgs = []
        
        try:
            perm = 'courses.accept_application' if accept else 'courses.reject_application' 
            if not user.has_perm(perm) and not user.is_superuser:
                msgs.append('У вас не хватает прав')
                raise AnyError
            
            try:
                app = Application.objects.select_related('course', 'user').only(
                    'course', 'user', 'date_submitted', 'course__id', 'user__id').get(id=app_id)
            except Application.DoesNotExist:
                msgs.append('Указанная заявка не существует')
                raise AnyError
            
            if not app.course.has_course_manager(user) and not user.is_superuser:
                msgs.append('Вы не являетесь менеджером данного курса')
                raise AnyError
            
            if accept:
                gr_students  = Group.objects.get(name='students')
                gr_newcomers = Group.objects.get(name='newcomers')
                groups = app.user.groups.all()
                if gr_newcomers in groups:
                    app.user.groups.remove(gr_newcomers)
                if gr_students not in groups:
                    app.user.groups.add(gr_students)
                enrollment, created = Enrollment.objects.get_or_create(course=app.course, user=app.user)
            
            app.delete()
            
            if accept and not created:
                msgs.append('Пользователь уже зачислен на этот курс')
                raise AnyError
            
            if accept:
                msgs.append('Пользователь зачислен на курс')
            else:
                msgs.append('Заявка отклонена')
            
        except AnyError:
            pass
        
        msg = u'Заявка <{0}>: '.format(info_title) + '; '.join(msgs)
        self.message_user(request, msg)



class EnrollmentAdmin(admin.ModelAdmin):
    
    date_hierarchy = 'date_enrolled'
    
    list_display       = ('id', 'date_enrolled', 'course', 'user')
    list_display_links = ('id', 'date_enrolled')
    list_filter        =       ('date_enrolled', 'course')
    search_fields      =                                  ('user__username',)
    
    ordering = ('date_enrolled', 'course')
    list_per_page = 20
    
    raw_id_fields = ('user', 'course')

    related_lookup_fields = {
        'fk': ['user', 'course'],
    }
    
    def formfield_for_foreignkey(self, db_field, request, **kwargs):
        u = request.user
        if db_field.name == 'course':
            q = u.courses_managing.all() if not u.is_superuser else Course.objects.all()
            kwargs['queryset'] = q.filter(is_active=True)
        elif db_field.name == 'user':
            q = User.objects.all()
            if not u.is_superuser:
                q = q.filter(groups__name__in=('newcomers', 'students'))
            kwargs['queryset'] = q
        return super(EnrollmentAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)
    
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



COURSE_ELEMENT_TYPES = (
    (Q(app_label='lectures') & Q(model='lecture')) |
    (Q(app_label='tests')    & Q(model='test'))
)



# TODO: presave checks for CourseElement if allowed elements used
# Lecture.courses_allowed and Test.scheme in 

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
            kwargs['queryset'] = ContentType.objects.filter(COURSE_ELEMENT_TYPES)
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
            kwargs['queryset'] = ContentType.objects.filter(COURSE_ELEMENT_TYPES)
        return super(CourseElementAdmin, self).formfield_for_foreignkey(db_field, request, **kwargs)



admin.site.register(Course, CourseAdmin)
admin.site.register(Part, CoursePartAdmin)
admin.site.register(Element, CourseElementAdmin)
admin.site.register(Application, ApplicationAdmin)
admin.site.register(Enrollment, EnrollmentAdmin)
