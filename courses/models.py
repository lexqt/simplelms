# coding: utf-8

from django.db import models
from django.contrib.auth.models import User
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes import generic
from django.http import Http404
from common.http import Http403

class Course(models.Model):
    
    class Meta:
        verbose_name        = 'курс'
        verbose_name_plural = 'курсы'
    
    title        = models.CharField('название', max_length=150)
    description  = models.TextField('описание', blank=True)
    is_active    = models.BooleanField('активный', default=False)
    date_created = models.DateField('дата создания', auto_now_add=True)
    
    students = models.ManyToManyField(User, verbose_name='записанные ученики',
                                      null=True,
                                      related_name='courses_learning',
                                      through='Enrollment')
    managers = models.ManyToManyField(User, verbose_name='управляющие',
                                      null=True, blank=True,
                                      related_name='courses_managing',
                                      db_table='courses_managers')
    
    def has_course_manager(self, user):
        if isinstance(user, User):
            user = user.id
        return 0 != self.managers.filter(pk=user).count()
    
    def has_student(self, user):
        if isinstance(user, User):
            user = user.id
        return 0 != self.students.filter(pk=user).count()
    
    def __unicode__(self):
        return self.title
    
    @classmethod
    def get_or_fail(cls, cid, check_existence=True, user=None, check_student=True, check_manager=True, queryset=None):
        if queryset is None:
            queryset = cls.objects
        try:
            course = queryset.get(id=cid)
        except cls.DoesNotExist:
            if check_existence:
                raise Http404('Курс не найден')
            else:
                return None
        
        if user.is_superuser:
            return course
        
        if check_student:
            cs = course.has_student(user)
        if check_manager:
            cm = course.has_course_manager(user)
        if check_student and check_manager:
            if not cs and not cm:
                raise Http403('Вы не записаны на данный курс и не являетесь его управляющим')
        else:
            if check_student:
                if not cs:
                    raise Http403('Вы не записаны на данный курс')
            elif check_manager:
                if not cm:
                    raise Http403('Вы не являетесь управляющим данного курса')
        
        return course



class Enrollment(models.Model):

    class Meta:
        verbose_name        = 'запись на курсы'
        verbose_name_plural = 'записи на курсы'
        unique_together = ('course', 'user')
    
    course        = models.ForeignKey(Course, related_name='enrollments')
    user          = models.ForeignKey(User, related_name='enrollments')
    date_enrolled = models.DateField('дата зачисления', auto_now_add=True)
    
    @classmethod
    def has_enrollment(cls, course, user):
        return 0 != cls.objects.filter(course=course, user=user).count()

    def __unicode__(self):
        return ' - '.join(map(unicode,(self.user, self.course)))



class Application(models.Model):

    class Meta:
        verbose_name        = 'заявка на курсы'
        verbose_name_plural = 'заявки на курсы'
        unique_together = ('course', 'user')
        
        permissions = (
            ("accept_application", "Право принятия заявок"),
            ("reject_application", "Право отклонения заявок"),
        )
    
    course         = models.ForeignKey(Course, related_name='applications_submitted')
    user           = models.ForeignKey(User, related_name='applications_submitted')
    date_submitted = models.DateField('дата подачи', auto_now_add=True)

    @classmethod
    def has_application(cls, course, user):
        return 0 != cls.objects.filter(course=course, user=user).count()

    def __unicode__(self):
        return ' - '.join(map(unicode,(self.user, self.course)))



class Certificate(models.Model):

    class Meta:
        verbose_name        = 'аттестат'
        verbose_name_plural = 'аттестаты'
    
    course        = models.ForeignKey(Course)
    user          = models.ForeignKey(User)
    date_enrolled = models.DateField('дата зачисления')
    date_finished = models.DateField('дата завершения')
    rating        = models.DecimalField('рейтинг', max_digits=5, decimal_places=2)



class Part(models.Model):

    class Meta:
        verbose_name        = 'раздел'
        verbose_name_plural = 'разделы'
        unique_together     = ('course', 'num')
        ordering = ('course', 'num')
        
    course      = models.ForeignKey(Course, related_name='parts')
    num         = models.PositiveIntegerField('номер')
    title       = models.CharField('название', max_length=150)
    description = models.TextField('описание', blank=True)
    
    def __unicode__(self):
        return self.title



class Element(models.Model):

    class Meta:
        verbose_name        = 'элемент'
        verbose_name_plural = 'элементы'
        unique_together     = ('part', 'num')
        ordering = ('part', 'num')
    
    part        = models.ForeignKey(Part, related_name='elements')
    num         = models.PositiveIntegerField('номер')
    title       = models.CharField('название', max_length=150)
    description = models.TextField('описание', blank=True)
    max_rating  = models.DecimalField('максимальный рейтинг', max_digits=5, decimal_places=2, default=0)

    element_type   = models.ForeignKey(ContentType, verbose_name='тип')
    object_id      = models.PositiveIntegerField('id связанного элемента')
    element_object = generic.GenericForeignKey('element_type', 'object_id')
    
    def __unicode__(self):
        return u'{0}. {1}'.format(self.num, self.title)
