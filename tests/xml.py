# coding: utf-8

from lxml import etree
from lxml import objectify
from django.utils.safestring import mark_safe
from django.utils.datastructures import SortedDict



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

class ScriptIndex(object):
    
    def __init__(self, scheme, script_id):
        self.scheme    = scheme
        self.script_id = script_id



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

    def get_for_answer_store(self, answer):
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
    
    def get_for_answer_store(self, answer):
        if not hasattr(answer, '__iter__'):
            answer = (answer,)
        return '\n'.join(map(lambda a: u'VariantID={0}: "{1}"'.format(a, self.variants[a]), answer))
    
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
        self.type = None
    
    def get_type(self):
        return self.type
    
    def parse_xml(self):
        o = self._dom
        types = ['String']
        for t in types:
            node = o.find(t)
            if node is not None:
                self.type = t.lower()
                break
        
        if self.type == 'string':
            obj          = o.String
            self.match_case = False if obj.get('MatchCase', 'No') == 'No' else True
        
        self.default = ''
        self.value   = obj.get('Value', '')
        self.obj = obj
    
    def get_answer_data(self):
        return self.default
    
    def check_answer(self, answer):
        check = False
        if self.type == 'string':
            if self.match_case:
                check = answer == self.value
            else:
                check = answer.lower() == self.value.lower()
        if check:
            return 1
        else:
            return 0
    
    def get_for_answer_store(self, answer):
        return answer
    
    def to_xml(self):
        E = objectify.ElementMaker(annotate=False)
        
        if self.type == 'string':
            frame_type = E.String(
                Value=self.value,
                MatchCase='Yes' if self.match_case else 'No'
            )
        
        e = E.Open(
            frame_type
        )
        
        return e




FRAME_TYPE_CLASSES = {
    'close': CloseType,
    'open': OpenType,
}



class TestScriptXml(object):
    
    TIME_SCALE_TYPES = {
        'Second': 'seconds',
        'Minute': 'minutes',
        'Hour': 'hours',
        'Day': 'days'
    }
    
    def __init__(self, xml=None, script_index=None, name=None, mode=None, time_limit=None):
        
        self.script_index = script_index
        self.name         = name
        self.mode         = mode
        self.time_limit   = time_limit
        if xml is not None:
            self.parse_xml(xml)
    
    def parse_xml(self, xml):
        self._xml = xml
        
        # prepare schema
        from django.conf import settings
        import os
        xsd_path = os.path.join(settings.CURRENT_APP_DIR, 'tests/schema/TestScripts.xsd')
        with file(xsd_path) as f:
            xsd = f.read()
        schema_root = etree.fromstring(xsd)
        schema = etree.XMLSchema(schema_root)
        parser = objectify.makeparser(schema = schema)
        
        dom = objectify.fromstring(xml, parser)
        self._dom = dom
        
        self.script_index = ScriptIndex(dom.get('Scheme'), dom.get('ScriptID'))
        
        test = dom.Test
        
        self.description = get_mixed_content(test.Description)
        self.name = test.get('Name')
        self.mode = test.get('Mode', 'Learning')
        
        from datetime import timedelta
        self._time_scale = test.get('TimeScale', 'Minute')
        arg = self.TIME_SCALE_TYPES[self._time_scale]
        self._time_limit = test.get('LimitOnScript')
        self.time_limit  = timedelta(**{arg: int(self._time_limit)})
        
        # TODO: randomize groups and frames support, etc
        
        groups = SortedDict()
        for group in test.TestGroup:
            gid = group.get('GroupID')
            frames = SortedDict()
            for item in group.FrameIndex:
                frame_index = FrameIndex(item.get('Scheme'), item.get('FrameID'))
                gi     = item.TestGroupItem
                giid   = gi.get('GroupItemID')
                weight = int(gi.get('Weight', 1))
                frames[giid] = {'index': frame_index, 'weight': weight}
            groups[gid] = frames
        self.groups = groups
        
        # TODO: multiple rules support
        
        try:
            import decimal
            decimal.getcontext().prec = 2
            threshold = decimal.Decimal(test.TestRules.TestRule.get('Percent'))
        except AttributeError:
            threshold = 0
        self.rating_threshold = threshold
    
    def get_frames(self):
        '''
        Returns sorted dict with frames:
        {
            <group item id>: {
                'index': <FrameIndex>,
                'weight': <weight>
            },
            ...
        }
        '''
        # TODO: randomize groups and frames support, etc
        
        frames = SortedDict()
        for group_frames in self.groups.values():
            frames.update(group_frames)
        
        return frames
    
    def is_exam(self):
        return self.mode == 'Exam'
    
    def to_xml(self):
        E = objectify.ElementMaker(annotate=False)
        
        groups = [E.TestGroup(
                *[E.FrameIndex(
                    E.TestGroupItem(
                        GroupItemID=giid,
                        Weight=unicode(frame['weight'])
                    ),
                    Scheme=frame['index'].scheme,
                    FrameID=frame['index'].frame_id
                )
                for giid, frame in group.items()],
                GroupID=gid
            )
            for gid, group in self.groups.items()
        ]
        
        args = groups + [
            E.TestRules(
                E.TestRule(
                    Percent=unicode(self.rating_threshold).replace('.00', '')
                )
            )
        ]
        
        e = E.ScriptIndex(
            E.Test(
                prepare_mixed_content('Description', self.description),
                *args,
                Name=self.name,
                Mode=self.mode,
                LimitOnScript=self._time_limit,
                TimeScale=self._time_scale
            ),
            Scheme=self.script_index.scheme,
            ScriptID=self.script_index.script_id
        )
        
        return etree.tostring(e, xml_declaration=True, encoding='utf-8', pretty_print=True)

