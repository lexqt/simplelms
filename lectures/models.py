# coding: utf-8

from django.db import models
from django.contrib.auth.models import User
from courses.models import ElementObject, Course

class Lecture(ElementObject):
    
    class Meta:
        verbose_name        = 'лекция'
        verbose_name_plural = 'лекции'
    
    title           = models.CharField('название', max_length=150)
    description     = models.TextField('описание', default='')
    
    def __unicode__(self):
        return self.title



class LecturePage(models.Model):
    
    class Meta:
        verbose_name        = 'страница'
        verbose_name_plural = 'страницы'
        ordering = ('lecture', 'num')
    
    lecture    = models.ForeignKey(Lecture, related_name='pages')
    title      = models.CharField('название', max_length=150)
    content    = models.TextField('текст лекции')
    num        = models.PositiveIntegerField('номер страницы')

    def __unicode__(self):
        return u'{0} - "{1}"'.format(self.lecture.title, self.title)



class LectureResult(models.Model):
    
    class Meta:
        verbose_name        = 'результат'
        verbose_name_plural = 'результаты'
    
    lecture    = models.ForeignKey(Lecture, related_name='results')
    course     = models.ForeignKey(Course, related_name='+')
    user       = models.ForeignKey(User, related_name='+')
    is_passed  = models.BooleanField('пройдено', default=True)

    @classmethod
    def pass_lecture(cls, lecture, course, user):
        result, created = cls.objects.get_or_create(lecture=lecture, course=course, user=user, defaults={'is_passed': True})
        if not created and not result.is_passed:
            result.is_passed = True
            result.save()
        return result
