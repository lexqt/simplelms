# encoding: utf-8
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models

class Migration(SchemaMigration):

    def forwards(self, orm):
        
        # Adding model 'TestFrame'
        db.create_table('tests_testframe', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('scheme', self.gf('django.db.models.fields.PositiveIntegerField')()),
            ('frame_id', self.gf('django.db.models.fields.PositiveIntegerField')()),
            ('title', self.gf('django.db.models.fields.CharField')(max_length=200)),
            ('frame_data', self.gf('django.db.models.fields.TextField')()),
        ))
        db.send_create_signal('tests', ['TestFrame'])

        # Adding unique constraint on 'TestFrame', fields ['scheme', 'frame_id']
        db.create_unique('tests_testframe', ['scheme', 'frame_id'])


    def backwards(self, orm):
        
        # Removing unique constraint on 'TestFrame', fields ['scheme', 'frame_id']
        db.delete_unique('tests_testframe', ['scheme', 'frame_id'])

        # Deleting model 'TestFrame'
        db.delete_table('tests_testframe')


    models = {
        'tests.testframe': {
            'Meta': {'unique_together': "(('scheme', 'frame_id'),)", 'object_name': 'TestFrame'},
            'frame_data': ('django.db.models.fields.TextField', [], {}),
            'frame_id': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'scheme': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '200'})
        }
    }

    complete_apps = ['tests']
