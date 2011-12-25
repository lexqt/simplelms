# coding: utf-8

from django.db import models
from django.contrib.auth.models import User

class UserProfile(models.Model):
    
    class Meta:
        verbose_name = 'профиль'
        verbose_name_plural = 'профили'
    
    user = models.OneToOneField(User, related_name='profile')
    
    middle_name = models.CharField('Отчество:', max_length=30, blank=True)
    
    def __unicode__(self):
        return ' '.join((self.user.last_name, self.user.first_name, self.middle_name))
