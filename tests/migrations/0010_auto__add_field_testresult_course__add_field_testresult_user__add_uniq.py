# encoding: utf-8
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models

class Migration(SchemaMigration):

    def forwards(self, orm):
        
        # Removing unique constraint on 'Session', fields ['user']
        db.delete_unique('tests_session', ['user_id'])

        # Adding field 'TestResult.course'
        db.add_column('tests_testresult', 'course', self.gf('django.db.models.fields.related.ForeignKey')(default=0, related_name='+', to=orm['courses.Course']), keep_default=False)

        # Adding field 'TestResult.user'
        db.add_column('tests_testresult', 'user', self.gf('django.db.models.fields.related.ForeignKey')(default=0, related_name='test_results', unique=True, to=orm['auth.User']), keep_default=False)

        # Adding unique constraint on 'TestResult', fields ['course', 'script_id', 'scheme', 'user', 'try_number']
        db.create_unique('tests_testresult', ['course_id', 'script_id', 'scheme', 'user_id', 'try_number'])

        # Changing field 'Session.user'
        db.alter_column('tests_session', 'user_id', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User']))


    def backwards(self, orm):
        
        # Removing unique constraint on 'TestResult', fields ['course', 'script_id', 'scheme', 'user', 'try_number']
        db.delete_unique('tests_testresult', ['course_id', 'script_id', 'scheme', 'user_id', 'try_number'])

        # Deleting field 'TestResult.course'
        db.delete_column('tests_testresult', 'course_id')

        # Deleting field 'TestResult.user'
        db.delete_column('tests_testresult', 'user_id')

        # Changing field 'Session.user'
        db.alter_column('tests_session', 'user_id', self.gf('django.db.models.fields.related.OneToOneField')(unique=True, to=orm['auth.User']))

        # Adding unique constraint on 'Session', fields ['user']
        db.create_unique('tests_session', ['user_id'])


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
        'courses.element': {
            'Meta': {'ordering': "('part', 'num')", 'unique_together': "(('part', 'num'),)", 'object_name': 'Element'},
            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'element_type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['contenttypes.ContentType']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'max_rating': ('django.db.models.fields.DecimalField', [], {'default': '0', 'max_digits': '5', 'decimal_places': '2'}),
            'num': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'object_id': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'part': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'elements'", 'to': "orm['courses.Part']"}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '150'})
        },
        'courses.enrollment': {
            'Meta': {'unique_together': "(('course', 'user'),)", 'object_name': 'Enrollment'},
            'course': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'enrollments'", 'to': "orm['courses.Course']"}),
            'date_enrolled': ('django.db.models.fields.DateField', [], {'auto_now_add': 'True', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'enrollments'", 'to': "orm['auth.User']"})
        },
        'courses.part': {
            'Meta': {'ordering': "('course', 'num')", 'unique_together': "(('course', 'num'),)", 'object_name': 'Part'},
            'course': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'parts'", 'to': "orm['courses.Course']"}),
            'description': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'num': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '150'})
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
            'scheme': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'script_id': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'test_sessions'", 'to': "orm['auth.User']"})
        },
        'tests.sessionframe': {
            'Meta': {'object_name': 'SessionFrame'},
            'answer': ('django.db.models.fields.TextField', [], {'blank': 'True'}),
            'frame': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'+'", 'to': "orm['tests.TestFrame']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_passed': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'next_sframe': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'previous'", 'null': 'True', 'to': "orm['tests.SessionFrame']"}),
            'rating': ('django.db.models.fields.FloatField', [], {'default': '0'}),
            'session': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'frames'", 'null': 'True', 'to': "orm['tests.Session']"}),
            'weight': ('django.db.models.fields.IntegerField', [], {'default': '1'})
        },
        'tests.test': {
            'Meta': {'unique_together': "(('scheme', 'script_id'),)", 'object_name': 'Test'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'scheme': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'script_data': ('django.db.models.fields.TextField', [], {}),
            'script_id': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '200'})
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
            'Meta': {'ordering': "['course', 'user', 'scheme', 'script_id', 'try_number']", 'unique_together': "(('course', 'user', 'scheme', 'script_id', 'try_number'),)", 'object_name': 'TestResult'},
            'course': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'+'", 'to': "orm['courses.Course']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_passed': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'rating': ('django.db.models.fields.DecimalField', [], {'default': '0', 'max_digits': '5', 'decimal_places': '2'}),
            'scheme': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'script_id': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'session': ('django.db.models.fields.related.OneToOneField', [], {'related_name': "'result'", 'unique': 'True', 'to': "orm['tests.Session']"}),
            'try_number': ('django.db.models.fields.SmallIntegerField', [], {'default': '1'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'related_name': "'test_results'", 'unique': 'True', 'to': "orm['auth.User']"})
        }
    }

    complete_apps = ['tests']
