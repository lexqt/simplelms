# encoding: utf-8
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models

class Migration(SchemaMigration):

    def forwards(self, orm):
        
        # Adding model 'TestResult'
        db.create_table('tests_testresult', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('session', self.gf('django.db.models.fields.related.OneToOneField')(related_name='result', unique=True, to=orm['tests.Session'])),
            ('rating', self.gf('django.db.models.fields.DecimalField')(default=0, max_digits=5, decimal_places=2)),
            ('try_number', self.gf('django.db.models.fields.SmallIntegerField')(default=1)),
        ))
        db.send_create_signal('tests', ['TestResult'])

        # Adding model 'TestScript'
        db.create_table('tests_testscript', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('scheme', self.gf('django.db.models.fields.PositiveIntegerField')()),
            ('script_id', self.gf('django.db.models.fields.PositiveIntegerField')()),
            ('title', self.gf('django.db.models.fields.CharField')(max_length=200)),
            ('script_data', self.gf('django.db.models.fields.TextField')()),
        ))
        db.send_create_signal('tests', ['TestScript'])

        # Adding unique constraint on 'TestScript', fields ['scheme', 'script_id']
        db.create_unique('tests_testscript', ['scheme', 'script_id'])

        # Adding model 'Session'
        db.create_table('tests_session', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('user', self.gf('django.db.models.fields.related.OneToOneField')(related_name='test_session', unique=True, to=orm['auth.User'])),
            ('course', self.gf('django.db.models.fields.related.ForeignKey')(related_name='+', to=orm['courses.Course'])),
            ('cur_session_frame', self.gf('django.db.models.fields.related.OneToOneField')(related_name='test_session', unique=True, null=True, to=orm['tests.SessionFrame'])),
            ('script', self.gf('django.db.models.fields.related.ForeignKey')(related_name='+', to=orm['tests.TestScript'])),
            ('num_passed', self.gf('django.db.models.fields.IntegerField')(default=0)),
            ('is_active', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('is_finished', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('date_started', self.gf('django.db.models.fields.DateTimeField')(null=True)),
            ('date_ended', self.gf('django.db.models.fields.DateTimeField')(null=True)),
            ('date_limit', self.gf('django.db.models.fields.DateTimeField')(null=True)),
        ))
        db.send_create_signal('tests', ['Session'])

        # Adding model 'SessionFrame'
        db.create_table('tests_sessionframe', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('frame', self.gf('django.db.models.fields.related.ForeignKey')(related_name='+', to=orm['tests.TestFrame'])),
            ('is_passed', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('answer', self.gf('django.db.models.fields.TextField')(blank=True)),
            ('weight', self.gf('django.db.models.fields.IntegerField')(default=1)),
            ('rating', self.gf('django.db.models.fields.FloatField')(default=0)),
            ('next_sframe', self.gf('django.db.models.fields.related.ForeignKey')(related_name='previous', null=True, to=orm['tests.SessionFrame'])),
        ))
        db.send_create_signal('tests', ['SessionFrame'])


    def backwards(self, orm):
        
        # Removing unique constraint on 'TestScript', fields ['scheme', 'script_id']
        db.delete_unique('tests_testscript', ['scheme', 'script_id'])

        # Deleting model 'TestResult'
        db.delete_table('tests_testresult')

        # Deleting model 'TestScript'
        db.delete_table('tests_testscript')

        # Deleting model 'Session'
        db.delete_table('tests_session')

        # Deleting model 'SessionFrame'
        db.delete_table('tests_sessionframe')


    models = {
        'auth.group': {
            'Meta': {'object_name': 'Group'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '80'}),
            'permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'})
        },
        'auth.permission': {
            'Meta': {'ordering': "('content_type__app_label', 'content_type__model', 'codename')", 'unique_together': "(('content_type', 'codename'),)", 'object_name': 'Permission'},
            'codename': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'content_type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['contenttypes.ContentType']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        'auth.user': {
            'Meta': {'object_name': 'User'},
            'date_joined': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75', 'blank': 'True'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'groups': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Group']", 'symmetrical': 'False', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'is_staff': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'is_superuser': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'last_login': ('django.db.models.fields.DateTimeField', [], {'default': 'datetime.datetime.now'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '30', 'blank': 'True'}),
            'password': ('django.db.models.fields.CharField', [], {'max_length': '128'}),
            'user_permissions': ('django.db.models.fields.related.ManyToManyField', [], {'to': "orm['auth.Permission']", 'symmetrical': 'False', 'blank': 'True'}),
            'username': ('django.db.models.fields.CharField', [], {'unique': 'True', 'max_length': '30'})
        },
        'contenttypes.contenttype': {
            'Meta': {'ordering': "('name',)", 'unique_together': "(('app_label', 'model'),)", 'object_name': 'ContentType', 'db_table': "'django_content_type'"},
            'app_label': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'model': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '100'})
        },
        'courses.course': {
            'Meta': {'object_name': 'Course'},
            'date_created': ('django.db.models.fields.DateField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'managers': ('django.db.models.fields.related.ManyToManyField', [], {'related_name': "'courses_managing'", 'to': "orm['auth.User']", 'db_table': "'courses_managers'", 'blank': 'True', 'symmetrical': 'False', 'null': 'True'}),
            'students': ('django.db.models.fields.related.ManyToManyField', [], {'symmetrical': 'False', 'related_name': "'courses_learning'", 'null': 'True', 'through': "orm['courses.Enrollment']", 'to': "orm['auth.User']"}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '150'})
        },
        'courses.enrollment': {
            'Meta': {'unique_together': "(('course', 'user'),)", 'object_name': 'Enrollment'},
            'course': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'enrollments'", 'to': "orm['courses.Course']"}),
            'date_enrolled': ('django.db.models.fields.DateField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'enrollments'", 'to': "orm['auth.User']"})
        },
        'tests.session': {
            'Meta': {'object_name': 'Session'},
            'course': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'+'", 'to': "orm['courses.Course']"}),
            'cur_session_frame': ('django.db.models.fields.related.OneToOneField', [], {'related_name': "'test_session'", 'unique': 'True', 'null': 'True', 'to': "orm['tests.SessionFrame']"}),
            'date_ended': ('django.db.models.fields.DateTimeField', [], {'null': 'True'}),
            'date_limit': ('django.db.models.fields.DateTimeField', [], {'null': 'True'}),
            'date_started': ('django.db.models.fields.DateTimeField', [], {'null': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'is_finished': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'num_passed': ('django.db.models.fields.IntegerField', [], {'default': '0'}),
            'script': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'+'", 'to': "orm['tests.TestScript']"}),
            'user': ('django.db.models.fields.related.OneToOneField', [], {'related_name': "'test_session'", 'unique': 'True', 'to': "orm['auth.User']"})
        },
        'tests.sessionframe': {
            'Meta': {'object_name': 'SessionFrame'},
            'answer': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'frame': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'+'", 'to': "orm['tests.TestFrame']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_passed': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'next_sframe': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'previous'", 'null': 'True', 'to': "orm['tests.SessionFrame']"}),
            'rating': ('django.db.models.fields.FloatField', [], {'default': '0'}),
            'weight': ('django.db.models.fields.IntegerField', [], {'default': '1'})
        },
        'tests.testframe': {
            'Meta': {'unique_together': "(('scheme', 'frame_id'),)", 'object_name': 'TestFrame'},
            'frame_data': ('django.db.models.fields.TextField', [], {}),
            'frame_id': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'frame_type': ('django.db.models.fields.CharField', [], {'max_length': '30'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'scheme': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '200'})
        },
        'tests.testresult': {
            'Meta': {'object_name': 'TestResult'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'rating': ('django.db.models.fields.DecimalField', [], {'default': '0', 'max_digits': '5', 'decimal_places': '2'}),
            'session': ('django.db.models.fields.related.OneToOneField', [], {'related_name': "'result'", 'unique': 'True', 'to': "orm['tests.Session']"}),
            'try_number': ('django.db.models.fields.SmallIntegerField', [], {'default': '1'})
        },
        'tests.testscript': {
            'Meta': {'unique_together': "(('scheme', 'script_id'),)", 'object_name': 'TestScript'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'scheme': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'script_data': ('django.db.models.fields.TextField', [], {}),
            'script_id': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '200'})
        }
    }

    complete_apps = ['tests']
