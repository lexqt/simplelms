# coding: utf-8

from django.db import models
from django.contrib.auth.models import User
from courses.models import ElementObject, Course
from django.core.urlresolvers import reverse


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
    
    def get_absolute_url(self):
        return reverse('tests:debug_frame', kwargs={'scheme': self.scheme, 'frame_id': self.frame_id})



class Test(ElementObject):
    
    class Meta:
        verbose_name        = 'тест'
        verbose_name_plural = 'тесты'
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
    
    scheme    = models.PositiveIntegerField('индекс схемы')
    frame_id  = models.PositiveIntegerField('индекс фрейма')
    is_passed = models.BooleanField('фрейм пройден', default=False)
    answer    = models.TextField('ответ учащегося', blank=True)
    weight    = models.IntegerField('вес фрейма', default=1)
    rating    = models.FloatField('полученные баллы', default=0)
    
    session   = models.ForeignKey('Session', related_name='frames')
    
    next_sframe = models.OneToOneField('SessionFrame', related_name='previous', null=True, blank=True)



class Session(models.Model):
    
    class Meta:
        verbose_name        = 'сессия прохождения теста'
        verbose_name_plural = 'сессии прохождения теста'
    
    course            = models.ForeignKey(Course, related_name='+')
    user              = models.ForeignKey(User, related_name='test_sessions')
    cur_session_frame = models.OneToOneField(SessionFrame, related_name='test_session', null=True, blank=True)
    
    scheme      = models.PositiveIntegerField('индекс схемы')
    script_id   = models.PositiveIntegerField('индекс сценария')
    num_passed  = models.IntegerField('число пройденных вопросов', default=0)
    is_active   = models.BooleanField('активная сессия', default=False)
    is_finished = models.BooleanField('тест пройден', default=False)
    
    is_exam = models.BooleanField('аттестующий тест', default=False)
    
    rating_threshold = models.DecimalField('порог набранного рейтинга', max_digits=5, decimal_places=2, default=0)
    
    date_started = models.DateTimeField('дата и время начала', null=True, blank=True)
    date_ended   = models.DateTimeField('дата и время окончания', null=True, blank=True)
    date_limit   = models.DateTimeField('крайние дата и время окончания', null=True, blank=True)
    
    @property
    def test(self):
        if not self.scheme or not self.script_id:
            return None
        if not hasattr(self, '_test'):
            try:
                t = Test.objects.defer('script_data').get(scheme=self.scheme, script_id=self.script_id)
                self._test = t
            except Test.DoesNotExist:
                self._test = None
        return self._test
    
    @test.setter
    def set_test(self, test):
        self._test = test
        self.scheme    = test.scheme
        self.script_id = test.script_id
    
    @classmethod
    def get_opened_session(cls, course, user, scheme=None, script_id=None):
        kwargs = {'is_finished': False, 'course': course, 'user': user}
        if scheme is not None:
            kwargs.update({'scheme': scheme, 'script_id': script_id})
        q = cls.objects.filter(**kwargs)
        if len(q):
            return q[0]
        else:
            return None
    
    def get_test_stats(self):
        sframes = SessionFrame.objects.only('is_passed', 'weight', 'rating').filter(session=self)
        cnt_total  = len(sframes)
        rate_total = reduce((lambda sum, frame: sum+frame.weight), sframes, 0)
        
        sframes = sframes.filter(rating__gt=0)
        cnt_right = len(sframes)
        rate_got  = reduce((lambda sum, frame: sum+frame.rating*frame.weight), sframes, 0)
        
        rate_got   = rate_got / rate_total * 100
        rate_total = 100
        
        return dict(count=dict(
                        total=cnt_total,
                        passed=self.num_passed,
                        right=cnt_right
                    ),
                    rating=dict(
                        total=rate_total,
                        got=rate_got
                    ))



class TestResult(models.Model):
    
    class Meta:
        verbose_name        = 'результат прохождения теста'
        verbose_name_plural = 'результаты прохождения теста'
        unique_together = ('course', 'user', 'scheme', 'script_id', 'try_number')
        ordering        = ['course', 'user', 'scheme', 'script_id', 'try_number']
    
    course = models.ForeignKey(Course, related_name='+')
    user   = models.ForeignKey(User, related_name='test_results')

    scheme    = models.PositiveIntegerField('индекс схемы')
    script_id = models.PositiveIntegerField('индекс сценария')
    session   = models.OneToOneField(Session, related_name='result')

    rating     = models.DecimalField('рейтинг', max_digits=5, decimal_places=2, default=0)
    is_passed  = models.BooleanField('тест зачтен', default=False)
    try_number = models.SmallIntegerField('номер попытки', default=1)
    
    @classmethod
    def check_passed(cls, course, user, scheme, script_id):
        res = cls.objects.only('is_passed').filter(course=course, user=user, scheme=scheme, script_id=script_id).reverse()
        if len(res):
            return res[0].is_passed
        else:
            return False
    
    @classmethod
    def get_next_try_number(cls, course, user, scheme, script_id):
        res = cls.objects.only('try_number').filter(course=course, user=user, scheme=scheme, script_id=script_id).reverse()
        if len(res):
            return res[0].try_number + 1
        else:
            return 1
