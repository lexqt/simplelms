# coding: utf-8

from django.db import models
from django.contrib.auth.models import User
from courses.models import Course



class TestFrame(models.Model):
    
    class Meta:
        verbose_name        = 'тестовое задание'
        verbose_name_plural = 'тестовые задания'
        unique_together = ('scheme', 'frame_id')

    scheme    = models.PositiveIntegerField('индекс схемы')
    frame_id  = models.PositiveIntegerField('индекс фрейма')
    title     = models.CharField('название вопроса', max_length=200)
    
    FRAME_TYPES = (
        ('close', 'Закрытый вопрос'),
        ('open', 'Открытый вопрос'),
    )
    
    frame_type = models.CharField('тип вопроса', max_length=30, choices=FRAME_TYPES)
    frame_data = models.TextField('xml сценарий')

    def __unicode__(self):
        return self.title
    
    def get_xml(self):
        xml = self.frame_data
        if isinstance(xml, unicode):
            xml = xml.encode('utf-8')
        return xml



class TestScript(models.Model):
    
    class Meta:
        verbose_name        = 'сценарий теста'
        verbose_name_plural = 'сценарии теста'
        unique_together = ('scheme', 'script_id')

    scheme    = models.PositiveIntegerField('индекс схемы')
    script_id = models.PositiveIntegerField('индекс сценария')
    title     = models.CharField('название теста', max_length=200)
    
    script_data = models.TextField('xml сценарий')

    def __unicode__(self):
        return self.title
    
    def get_xml(self):
        xml = self.script_data
        if isinstance(xml, unicode):
            xml = xml.encode('utf-8')
        return xml


    
class SessionFrame(models.Model):
    
    class Meta:
        verbose_name        = 'фрейм сессии прохождения теста'
        verbose_name_plural = 'фреймы сессии прохождения теста'
    
    frame     = models.ForeignKey(TestFrame, related_name='+')
    is_passed = models.BooleanField('фрейм пройден', default=False)
    answer    = models.TextField('ответ учащегося', blank=True)
    weight    = models.IntegerField('вес фрейма', default=1)
    rating    = models.FloatField('полученные баллы', default=0)
    
    next_sframe = models.ForeignKey('SessionFrame', null=True, related_name='previous')



class Session(models.Model):
    
    class Meta:
        verbose_name        = 'сессия прохождения теста'
        verbose_name_plural = 'сессии прохождения теста'
    
    user              = models.OneToOneField(User, unique=True, related_name='test_session')
    course            = models.ForeignKey(Course, related_name='+')
    cur_session_frame = models.OneToOneField(SessionFrame, null=True, related_name='test_session')
    
    script      = models.ForeignKey(TestScript, related_name='+')
    num_passed  = models.IntegerField('число пройденных вопросов', default=0)
    is_active   = models.BooleanField('активная сессия', default=False)
    is_finished = models.BooleanField('тест пройден', default=False)
    
    date_started = models.DateTimeField('дата и время начала', null=True)
    date_ended   = models.DateTimeField('дата и время окончания', null=True)
    date_limit   = models.DateTimeField('крайние дата и время окончания', null=True)



class TestResult(models.Model):
    
    class Meta:
        verbose_name        = 'результат прохождения теста'
        verbose_name_plural = 'результаты прохождения теста'
    
    session  = models.OneToOneField(Session, related_name='result')
    rating   = models.DecimalField('рейтинг', max_digits=5, decimal_places=2, default=0)
    try_number = models.SmallIntegerField('номер попытки', default=1)
