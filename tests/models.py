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
        
        permissions = (
            ('debug_frame', 'Право тестировать фреймы'),
        )

    scheme    = models.PositiveIntegerField('индекс схемы')
    frame_id  = models.PositiveIntegerField('индекс фрейма')
    title     = models.CharField('название вопроса', max_length=200)
    
    FRAME_TYPES = (
        ('close', 'Закрытый вопрос'),
        ('open', 'Открытый вопрос'),
    )
    FRAME_TYPES_DICT = dict(FRAME_TYPES)
    
    frame_type = models.CharField('тип вопроса', max_length=30, choices=FRAME_TYPES)
    frame_data = models.TextField('xml сценарий')

    def get_xml(self):
        xml = self.frame_data
        if isinstance(xml, unicode):
            xml = xml.encode('utf-8')
        return xml
    
    def get_absolute_url(self):
        return reverse('tests:debug_frame', kwargs={'scheme': self.scheme, 'frame_id': self.frame_id})
    
    def __unicode__(self):
        return u'Фрейм[{0}][{1}] тип[{2}] "{3}"'.format(
            self.scheme, self.frame_id,
            self.FRAME_TYPES_DICT[self.frame_type],
            self.title,
            )



class Test(ElementObject):
    
    class Meta:
        verbose_name        = 'тест'
        verbose_name_plural = 'тесты'
        unique_together = ('scheme', 'script_id')

    scheme    = models.PositiveIntegerField('индекс схемы')
    script_id = models.PositiveIntegerField('индекс сценария')
    title     = models.CharField('название теста', max_length=200)
    
    script_data = models.TextField('xml сценарий')

    def get_xml(self):
        xml = self.script_data
        if isinstance(xml, unicode):
            xml = xml.encode('utf-8')
        return xml
    
    def __unicode__(self):
        return u'Тест[{0}][{1}] "{2}"'.format(
            self.scheme, self.script_id,
            self.title,
            )


    
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
    
    session   = models.ForeignKey('Session', verbose_name='сессия прохождения теста', related_name='frames')
    
    next_sframe = models.OneToOneField('SessionFrame', verbose_name='следующий фрейм', related_name='previous', null=True, blank=True)
    
    def get_absolute_url(self):
        try:
            frame = TestFrame.objects.get(scheme=self.scheme, frame_id=self.frame_id)
            return frame.get_absolute_url()
        except TestFrame.DoesNotExist:
            return ''
    
    def __unicode__(self):
        return u'{0} || фрейм[{1}][{2}] - [{3}] [{4} x {5:.2f}]'.format(
            self.session,
            self.scheme, self.frame_id,
            '>>' if self.is_passed else '--',
            self.weight, self.rating,
            )



class Session(models.Model):
    
    class Meta:
        verbose_name        = 'сессия прохождения теста'
        verbose_name_plural = 'сессии прохождения теста'
    
    course            = models.ForeignKey(Course, verbose_name='курс', related_name='+')
    user              = models.ForeignKey(User, verbose_name='пользователь', related_name='test_sessions')
    cur_session_frame = models.OneToOneField(SessionFrame, related_name='test_session', null=True, blank=True)
    
    scheme      = models.PositiveIntegerField('индекс схемы')
    script_id   = models.PositiveIntegerField('индекс сценария')
    num_passed  = models.IntegerField('число пройденных вопросов', default=0)
    is_active   = models.BooleanField('активная сессия', default=False)
    is_finished = models.BooleanField('сессия завершена', default=False)
    
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
    
    def get_test_frame_count_total(self):
        return len(SessionFrame.objects.only('is_passed', 'weight', 'rating').filter(session=self))
    
    def __unicode__(self):
        return u'{0} - {1} - тест[{2}][{3}] - открыто {4} [{5}] [{6}]'.format(
            self.course, self.user,
            self.scheme, self.script_id,
            self.date_started,
            'активно'   if self.is_active   else 'остановлено',
            'завершено' if self.is_finished else 'не завершено',
            )



class TestResult(models.Model):
    
    class Meta:
        verbose_name        = 'результат прохождения теста'
        verbose_name_plural = 'результаты прохождения теста'
        unique_together = ('course', 'user', 'scheme', 'script_id', 'try_number')
        ordering        = ['course', 'user', 'scheme', 'script_id', 'try_number']
    
    course = models.ForeignKey(Course, verbose_name='курс', related_name='+')
    user   = models.ForeignKey(User, verbose_name='пользователь', related_name='test_results')

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
    
    def __unicode__(self):
        return u'{0} - {1} - тест[{2}][{3}] - #{4} [{5}]'.format(
            self.course, self.user,
            self.scheme, self.script_id,
            self.try_number,
            'зачтено' if self.is_passed else 'не зачтено',
            )



class SchemeCourseRelation(models.Model):
    
    class Meta:
        verbose_name        = 'отношение Курс - Схема'
        verbose_name_plural = 'отношения Курс - Схема'
        unique_together = ('course', 'scheme')
        ordering        = ['course', 'scheme']
    
    course = models.ForeignKey(Course, verbose_name='курс', related_name='alowed_test_schemes')
    scheme = models.PositiveIntegerField('индекс схемы')
    
    def __unicode__(self):
        return u'{0} - {1}'.format(self.course, self.scheme)
    
    @classmethod
    def get_courses_schemes(cls, courses=None, only_scheme_list=False, get_all=False):
        qs = cls.objects.all()
        if not get_all:
            if not hasattr(courses, '__iter__'):
                courses = (courses,)
            qs = qs.filter(course__in=courses)
        if only_scheme_list:
            return list(qs.order_by('scheme').values_list('scheme', flat=True))
        else:
            vl = qs.values_list('course__title', 'scheme')
            d = {}
            for pair in vl:
                title = pair[0]
                num   = pair[1]
                if d.has_key(num):
                    d[num].append(title)
                else:
                    d[num] = [title]
            return map(lambda pair: (pair[0], u', '.join(pair[1])), d.items())

