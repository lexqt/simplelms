# coding: utf-8

from django.contrib import admin
from common.admin import LinkedStackedInline
from .models import TestFrame, Test, Session, SessionFrame, TestResult, SchemeCourseRelation



class SchemeControlMixin(object):
    
    model = None
    
    def queryset(self, request):
        qs = super(SchemeControlMixin, self).queryset(request)
        if request.user.is_superuser:
            return qs
        
        schemes = SchemeCourseRelation.get_courses_schemes(request.user.courses_managing.all(), only_scheme_list=True)
        schemes.append(0)
        return qs.filter(scheme__in=schemes)
    
    @staticmethod
    def _get_schemes(user):
        if user.is_superuser:
            schemes = SchemeCourseRelation.get_courses_schemes(get_all=True)
        else:
            schemes = SchemeCourseRelation.get_courses_schemes(user.courses_managing.all())
        schemes = map(lambda pair: (pair[0], u'{0} - {1}'.format(*pair)), schemes)
        schemes.append((0, 'Временная схема'))
        return schemes
    
    def get_form(self, request, obj=None, **kwargs):
        schemes = self._get_schemes(request.user)
        
        # dirty hack
        from django import forms
        class SpecForm(forms.ModelForm):
            class Meta:
                model = self.model
            scheme = forms.TypedChoiceField(label='Индекс схемы', coerce=int, choices=schemes)
        
        self.form = SpecForm
        form = super(SchemeControlMixin, self).get_form(request, obj, **kwargs)
        return form


class TFAMixin(SchemeControlMixin):
    model = TestFrame
    
class TestFrameAdmin(TFAMixin, admin.ModelAdmin):
    pass



class TAMixin(SchemeControlMixin):
    model = Test
    
class TestAdmin(TAMixin, admin.ModelAdmin):
    pass



class SessionFrameInlineAdmin(LinkedStackedInline):
    
    model = SessionFrame
    
    fieldsets = (
        (None, {
            'fields': (('scheme', 'frame_id'), ('is_passed', 'weight', 'rating'), 'answer', 'next_sframe')
        }),
    )
    extra = 0
    
    def get_readonly_fields(self, request, obj=None):
        if obj is None:
            return tuple()
        else:
            return ('answer', 'scheme', 'frame_id', 'is_passed', 'weight', 'rating', 'next_sframe')



class SAMixin(SchemeControlMixin):
    model = Session
    
class SessionAdmin(SAMixin, admin.ModelAdmin):
    
    date_hierarchy = 'date_started'
    
    list_display       = ('id', 'course', 'user', 'scheme', 'script_id', 'is_exam', 'num_passed', 'is_active', 'is_finished', 'date_started', 'date_ended')
    list_display_links = ('id',)
    list_filter        = (      'course',                                'is_exam',               'is_active', 'is_finished', 'date_started', 'date_ended')
    
    list_per_page = 20
    
    raw_id_fields = ('user', 'course', 'cur_session_frame')

    related_lookup_fields = {
        'fk': ['user', 'course', 'cur_session_frame'],
    }
    
    inlines = (SessionFrameInlineAdmin,)
    
    def get_readonly_fields(self, request, obj=None):
        if obj is None:
            return tuple()
        else:
            return ('course', 'user', 'scheme', 'script_id', 'is_exam', 'num_passed', 'is_active', 'is_finished', 'date_started', 'date_limit', 'date_ended', 'cur_session_frame', 'rating_threshold')
    
    def queryset(self, request):
        qs = super(SessionAdmin, self).queryset(request)
        if request.user.is_superuser:
            return qs
        courses = request.user.courses_managing.only('id')
        return qs.filter(course__in=courses)



class SFAMixin(SchemeControlMixin):
    model = SessionFrame
    
class SessionFrameAdmin(SFAMixin, admin.ModelAdmin):
    
    list_display       = ('id', 'session', 'scheme', 'frame_id', 'is_passed', 'weight', 'rating')
    list_display_links = ('id',)
    list_filter        = ('is_passed',)
    
    list_per_page = 20
    
    raw_id_fields = ('session', 'next_sframe')

    related_lookup_fields = {
        'fk': ['session', 'next_sframe'],
    }
    
    def get_readonly_fields(self, request, obj=None):
        if obj is None:
            return tuple()
        else:
            return ('answer', 'session', 'scheme', 'frame_id', 'is_passed', 'weight', 'rating', 'next_sframe')




class TestResultAdmin(admin.ModelAdmin):
    pass



class SchemeCourseRelationAdmin(admin.ModelAdmin):
    pass



admin.site.register(TestFrame, TestFrameAdmin)
admin.site.register(Test, TestAdmin)
admin.site.register(Session, SessionAdmin)
admin.site.register(TestResult, TestResultAdmin)
admin.site.register(SchemeCourseRelation, SchemeCourseRelationAdmin)
admin.site.register(SessionFrame, SessionFrameAdmin)
