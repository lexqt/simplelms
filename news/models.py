# coding=utf-8

from django.db import models
from django.contrib.auth.models import User

class Article(models.Model):
    
    class Meta:
        verbose_name = 'статья'
        verbose_name_plural = 'статьи'
        get_latest_by = 'created'
        
    title     = models.CharField('заголовок', max_length=200)
    content   = models.TextField('текст статьи')
    published = models.BooleanField('опубликовано', default=False)
    author    = models.ForeignKey(User, verbose_name='автор')
    created   = models.DateTimeField('дата создания')

    def __unicode__(self):
        return self.title
