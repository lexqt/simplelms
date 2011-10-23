# coding: utf-8

from django import forms
from django.contrib.auth.models import User
from accounts.models import UserProfile


class UserForm(forms.ModelForm):
    class Meta:
        model  = User
        fields = ('username', 'last_name', 'first_name', 'email')
        
    username = forms.RegexField(label="Логин", max_length=30, regex=r'^[\w.@+-]+$',
        help_text = "Обязательно для заполнения. Не более 30 символов: латинские буквы, цифры и знаки @/./+/-/_.",
        error_messages = {'invalid': "Логин может состоять только из латинских букв, цифр и знаков @/./+/-/_."})
    password1 = forms.CharField(label="Пароль", widget=forms.PasswordInput)
    password2 = forms.CharField(label="Повторите пароль", widget=forms.PasswordInput,
        help_text = "Введите пароль еще раз для проверки правильности заполнения поля.")
    
    def __init__(self, *args, **kwargs):
        super(UserForm, self).__init__(*args, **kwargs)
        self.fields['email'].required = True
        self.fields['last_name'].required = True
        self.fields['first_name'].required = True

    def clean_username(self):
        username = self.cleaned_data["username"]
        try:
            User.objects.get(username=username)
        except User.DoesNotExist:
            return username
        raise forms.ValidationError("Пользователь с таким логином уже существует")

    def clean_password2(self):
        password1 = self.cleaned_data.get('password1', '')
        password2 = self.cleaned_data['password2']
        if password1 != password2:
            raise forms.ValidationError("Пароли не совпадают")
        return password2

    def save(self, commit=True):
        user = super(UserForm, self).save(commit=False)
        user.set_password(self.cleaned_data['password1'])
        if commit:
            user.save()
        return user



class UserProfileForm(forms.ModelForm):
    class Meta:
        model   = UserProfile
        exclude = ('user',)

    def __init__(self, *args, **kwargs):
        super(UserProfileForm, self).__init__(*args, **kwargs)
        self.fields['middle_name'].required = True

