# coding: utf-8

from django.db import models
from django.contrib.contenttypes import generic
from django.contrib.auth.models import User
from courses.models import Element, Course

class Lection(models.Model):
    
    class Meta:
        verbose_name        = 'лекция'
        verbose_name_plural = 'лекции'
    
    title           = models.CharField('название', max_length=150)
    description     = models.TextField('описание', default='')
    course_elements = generic.GenericRelation(Element,
                                              content_type_field='element_type',
                                              object_id_field='object_id')
    
    def in_course(self, course):
        return 0 != self.course_elements.filter(part__course=course).count()
    
    def __unicode__(self):
        return self.title



class LectionPage(models.Model):
    
    class Meta:
        verbose_name        = 'страница'
        verbose_name_plural = 'страницы'
        ordering = ('lection', 'num')
    
    lection    = models.ForeignKey(Lection, related_name='pages')
    title      = models.CharField('название', max_length=150)
    content    = models.TextField('текст лекции')
    num        = models.PositiveIntegerField('номер страницы')

    def __unicode__(self):
        return '{0} - "{1}"'.format(self.lection.title, self.title)



class LectionResult(models.Model):
    
    class Meta:
        verbose_name        = 'результат'
        verbose_name_plural = 'результаты'
    
    lection    = models.ForeignKey(Lection, related_name='results')
    course     = models.ForeignKey(Course, related_name='+')
    user       = models.ForeignKey(User, related_name='+')
    is_passed  = models.BooleanField('пройдено', default=True)

    @classmethod
    def pass_lection(cls, lection, course, user):
        result, created = cls.objects.get_or_create(lection=lection, course=course, user=user, defaults={'is_passed': True})
        if not created and not result.is_passed:
            result.is_passed = True
            result.save()
        return result
