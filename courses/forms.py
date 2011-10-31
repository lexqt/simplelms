# coding: utf-8
from django import forms
from .models import Enrollment

class EnrollmentAdminForm(forms.ModelForm):
    class Meta:
        model = Enrollment
        
    def clean_course(self):
        course = self.cleaned_data['course']
        if getattr(self, 'current_user', None) is None:
            raise forms.ValidationError("Не установлен текущий пользователь")
        if not course.has_course_manager(self.current_user):
            raise forms.ValidationError("Нет прав для управления выбранным курсом")
        
        return course
