# encoding: utf-8
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models

class Migration(SchemaMigration):

    def forwards(self, orm):
        
        # Adding field 'TestFrame.frame_type'
        db.add_column('tests_testframe', 'frame_type', self.gf('django.db.models.fields.CharField')(default='close', max_length=30), keep_default=False)


    def backwards(self, orm):
        
        # Deleting field 'TestFrame.frame_type'
        db.delete_column('tests_testframe', 'frame_type')


    models = {
        'tests.testframe': {
            'Meta': {'unique_together': "(('scheme', 'frame_id'),)", 'object_name': 'TestFrame'},
            'frame_data': ('django.db.models.fields.TextField', [], {}),
            'frame_id': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'frame_type': ('django.db.models.fields.CharField', [], {'max_length': '30'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'scheme': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '200'})
        }
    }

    complete_apps = ['tests']
