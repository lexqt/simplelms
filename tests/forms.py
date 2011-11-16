# coding: utf-8

from django import forms

class CloseTypeForm(forms.Form):
    
    def __init__(self, variants=(), *args, **kwargs):
        super(CloseTypeForm, self).__init__(*args, **kwargs)
        self.fields['answer'].choices = variants
    
    answer = forms.ChoiceField()



class OpenTypeForm(forms.Form):
    
    def __init__(self, default_value, *args, **kwargs):
        super(OpenTypeForm, self).__init__(*args, **kwargs)
        self.fields['answer'].initial = default_value
    
    answer = forms.CharField()



class SingleCloseTypeForm(CloseTypeForm):
    
    answer = forms.ChoiceField(widget=forms.RadioSelect, label='ответ',
                                error_messages={
                                    'required': 'Вам необходимо выбрать один вариант из предложенных',
                                    'invalid_choice': 'Вы выбрали вариант, не представленный в списке возможных ответов'})



class MultipleCloseTypeForm(CloseTypeForm):
    
    answer = forms.MultipleChoiceField(widget=forms.CheckboxSelectMultiple, label='ответ',
                                error_messages={
                                    'required': 'Вам необходимо выбрать хотя бы один вариант из предложенных',
                                    'invalid_choice': 'Один из выбранных Вами вариантов не представлен в списке возможных ответов'})



class StringOpenTypeForm(OpenTypeForm):

    answer = forms.CharField(error_messages={
                                    'required': 'Вам необходимо вписать ответ. Поле для ответа не должно быть пустым'})
