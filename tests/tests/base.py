import os
import sys
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
sys.path.append(os.path.abspath(CURRENT_DIR+'/../..'))
sys.path.append(os.path.abspath(CURRENT_DIR+'/../../..'))

os.environ['DJANGO_SETTINGS_MODULE'] = 'simplelms.settings'

import unittest
from tests.models import TestFrameXml, CloseType

class TestFrameTests(unittest.TestCase):
    
    def test_load_and_dump_close_type_frame(self):
        with file(CURRENT_DIR + '/data/frame_close_1_1.xml') as f:
            xml = f.read()
        frame = TestFrameXml(CloseType, xml)
        print '-----BEGIN-----'
        print frame.to_xml()
        print '------END------'

if __name__=='__main__':
    unittest.main()
