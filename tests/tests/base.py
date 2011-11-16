import os
import sys
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.abspath(CURRENT_DIR+'/../..'))
sys.path.append(os.path.abspath(CURRENT_DIR+'/../../..'))

os.environ['DJANGO_SETTINGS_MODULE'] = 'simplelms.settings'

import unittest
from tests.models import TestFrameXml, CloseType, OpenType


def assertXmlEqual(result, expect):
    from doctest import Example
    from lxml.doctestcompare import LXMLOutputChecker
    checker = LXMLOutputChecker()
    if not checker.check_output(expect, result, 0):
        message = checker.output_difference(Example("", expect), result, 0)
        raise AssertionError(message)

class TestFrameTests(unittest.TestCase):
    
    def test_load_and_dump_single_close_type_frame(self):
        '''PARSE AND DUMP SINGLE CLOSE TEST FRAME'''
        with file(CURRENT_DIR + '/data/frame_close_1_1.xml') as f:
            xml = f.read()
        frame = TestFrameXml(CloseType, xml)
        assertXmlEqual(frame.to_xml(), xml)
    
    def test_load_and_dump_multiple_close_type_frame(self):
        '''PARSE AND DUMP MULTIPLE CLOSE TEST FRAME'''
        with file(CURRENT_DIR + '/data/frame_close_1_2.xml') as f:
            xml = f.read()
        frame = TestFrameXml(CloseType, xml)
        assertXmlEqual(frame.to_xml(), xml)

    def test_load_and_dump_string_open_type_frame(self):
        '''PARSE AND DUMP STRING OPEN TEST FRAME'''
        with file(CURRENT_DIR + '/data/frame_open_1_1.xml') as f:
            xml = f.read()
        frame = TestFrameXml(OpenType, xml)
        assertXmlEqual(frame.to_xml(), xml)

if __name__=='__main__':
    unittest.main()
