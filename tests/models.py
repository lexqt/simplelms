# coding: utf-8

from django.db import models



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


