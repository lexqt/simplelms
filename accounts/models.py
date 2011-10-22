# coding: utf-8

from django.db import models
from django.contrib.auth.models import User

class UserProfile(models.Model):
    
    class Meta:
        verbose_name = 'профиль'
        verbose_name_plural = 'профили'
    
    user = models.OneToOneField(User)
    
    middle_name = models.CharField('отчество', max_length=30, blank=True)
    
    def __unicode__(self):
        return self.user.__unicode__()
