# coding: utf-8

from django.db import models
from django.utils.safestring import mark_safe



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
    





# XML MODELS

from lxml import etree
from lxml import objectify

def get_mixed_content(dom_element):
    strs = map(lambda g: etree.tostring(g, encoding=unicode), dom_element.iterchildren())
    if dom_element.text:
        strs.insert(0, dom_element.text)
    return mark_safe(' '.join(map(lambda x: x.strip(), strs)))

def prepare_mixed_content(dom_tag, content):
    xml = u'<{0}>{1}</{0}>'.format(dom_tag, content)
    return objectify.fromstring(xml)
    

class FrameIndex(object):
    
    def __init__(self, scheme, frame_id):
        self.scheme   = scheme
        self.frame_id = frame_id

class TestFrameXml(object):
    
    def __init__(self, frame_type, xml=None, frame_index=None, name=None, data=None):
        self.frame_type  = frame_type
        self.type = None
        
        self.frame_index = frame_index
        self.name        = name
        self.data        = data
        if xml is not None:
            self.parse_xml(xml)
    
    def parse_xml(self, xml):
        self._xml = xml
        
        # prepare schema
        from django.conf import settings
        import os
        xsd_path = os.path.join(settings.CURRENT_APP_DIR, 'tests/schema/TestFrames.xsd')
        with file(xsd_path) as f:
            xsd = f.read()
        schema_root = etree.fromstring(xsd)
        schema = etree.XMLSchema(schema_root)
        parser = objectify.makeparser(schema = schema)
#        parser = etree.XMLParser(schema = schema)
        
        dom = objectify.fromstring(xml, parser)
        self._dom = dom
        if self.type is None:
            self.type = self.frame_type(dom.TestFrame)
        
        self.frame_index = FrameIndex(dom.get('Scheme'), dom.get('FrameID'))
        self.name = dom.TestFrame.get('Name')
        self.data = get_mixed_content(dom.TestFrame.Data)
        
        self.type.parse_xml()

    def to_xml(self):
#        from lxml.builder import E
        t_element = self.type.to_xml()
        E = objectify.ElementMaker(annotate=False)
        e = E.FrameIndex(
            E.TestFrame(
                prepare_mixed_content('Data', self.data),
                t_element,
                Name=self.name
            ),
            Scheme=self.frame_index.scheme,
            FrameID=self.frame_index.frame_id
        )
        
        return etree.tostring(e, xml_declaration=True, encoding='utf-8', pretty_print=True)
    



class FrameType(object):
    
    def __init__(self, dom):
        if dom.tag != 'TestFrame':
            raise Exception('Not a TestFrame element given')
        self._dom = dom

    def parse_xml(self):
        raise NotImplementedError

    def to_xml(self):
        raise NotImplementedError

    def check_answer(self, answer):
        raise NotImplementedError

    def get_answer_data(self):
        raise NotImplementedError



class CloseType(FrameType):
    
    tag = 'Close'
    
    def __init__(self, dom):
        super(CloseType, self).__init__(dom)
        self._dom = dom.Close
        self.right_vars   = {}
        self.wrong_vars   = {}
        self.orig_variants = []
    
    @property
    def variants(self):
        if not hasattr(self, '_all_var'):
            all_var = {}
            all_var.update(self.right_vars)
            all_var.update(self.wrong_vars)
            self._all_var = all_var
        return self._all_var
    
    def is_multiple(self):
        cnt = len(self.right_vars)
        if 0 == cnt:
            raise Exception('DOM is not parsed yet or incorrect frame content')
        return cnt > 1
    
    def parse_xml(self):
        for var in self._dom.Variant:
            is_right = var.get('Value') == 'Right'
            var_id   = var.get('VariantID')
            data     = get_mixed_content(var.Data)
            
            container         = self.right_vars if is_right else self.wrong_vars
            container[var_id] = data
            
            self.orig_variants.append({
                'id': var_id,
                'right': is_right,
                'data': data
            })
    
    def get_answer_data(self):
        import random
        ii = self.variants.items()
        random.shuffle(ii)
        return ii
    
    def check_answer(self, answer):
#        answer = map(str, answer)
        cnt = len(self.right_vars)
        if 1 == cnt and self.right_vars.has_key(answer):
            return 1
        if cnt > 1:
            a = set(answer)
            r = set(self.right_vars)
            if a == r:
                return 1
            elif a < r:
                return float(len(a)) / cnt
        return 0
    
    def to_xml(self):
        E = objectify.ElementMaker(annotate=False)
        
        variants = [E.Variant(
            prepare_mixed_content('Data', var['data']),
            VariantID=var['id'],
            Value='Right' if var['right'] else 'Wrong')
        for var in self.orig_variants]
        
        e = E.Close(
            *variants
        )
        
        return e



class OpenType(FrameType):
    
    tag = 'Open'
    
    def __init__(self, dom):
        super(OpenType, self).__init__(dom)
        self._dom = dom.Open
        self._type = None
    
    def get_type(self):
        return self._type
    
    def parse_xml(self):
        o = self._dom
        types = ['String']
        for t in types:
            node = o.find(t)
            if node is not None:
                self._type = t.lower()
                break
        
#        if self._type == 'string':
        self.value  = o.String.get('Value', '')
        self.default = o.String.get('Default', '')
    
    def get_answer_data(self):
        return self.default
    
    def check_answer(self, answer):
        if answer == self.value:
            return 1
        else:
            return 0
    
    def to_xml(self):
        E = objectify.ElementMaker(annotate=False)
        
        if self._type == 'string':
            frame_type = E.String(Value=self.value)
        
        e = E.Open(
            frame_type
        )
        
        return e




FRAME_TYPE_CLASSES = {
    'close': CloseType,
    'open': OpenType,
}


