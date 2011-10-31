# encoding: utf-8
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models

class Migration(SchemaMigration):

    def forwards(self, orm):
        
        # Adding model 'Course'
        db.create_table('courses_course', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('title', self.gf('django.db.models.fields.CharField')(max_length=150)),
            ('description', self.gf('django.db.models.fields.TextField')(default='')),
            ('active', self.gf('django.db.models.fields.BooleanField')(default=False)),
        ))
        db.send_create_signal('courses', ['Course'])

        # Adding M2M table for field managers on 'Course'
        db.create_table('courses_managers', (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('course', models.ForeignKey(orm['courses.course'], null=False)),
            ('user', models.ForeignKey(orm['auth.user'], null=False))
        ))
        db.create_unique('courses_managers', ['course_id', 'user_id'])

        # Adding model 'Enrollment'
        db.create_table('courses_enrollment', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('course', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['courses.Course'])),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
            ('date_enrolled', self.gf('django.db.models.fields.DateField')()),
        ))
        db.send_create_signal('courses', ['Enrollment'])

        # Adding model 'Application'
        db.create_table('courses_application', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('course', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['courses.Course'])),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
            ('date_submitted', self.gf('django.db.models.fields.DateField')()),
        ))
        db.send_create_signal('courses', ['Application'])

        # Adding model 'Certificate'
        db.create_table('courses_certificate', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('course', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['courses.Course'])),
            ('user', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['auth.User'])),
            ('date_enrolled', self.gf('django.db.models.fields.DateField')()),
            ('date_finished', self.gf('django.db.models.fields.DateField')()),
            ('rating', self.gf('django.db.models.fields.DecimalField')(max_digits=5, decimal_places=2)),
        ))
        db.send_create_signal('courses', ['Certificate'])

        # Adding model 'Part'
        db.create_table('courses_part', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('course', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['courses.Course'])),
            ('num', self.gf('django.db.models.fields.IntegerField')()),
            ('title', self.gf('django.db.models.fields.CharField')(max_length=150)),
            ('description', self.gf('django.db.models.fields.TextField')(default='')),
        ))
        db.send_create_signal('courses', ['Part'])

        # Adding unique constraint on 'Part', fields ['course', 'num']
        db.create_unique('courses_part', ['course_id', 'num'])

        # Adding model 'Element'
        db.create_table('courses_element', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('part', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['courses.Part'])),
            ('num', self.gf('django.db.models.fields.IntegerField')()),
            ('title', self.gf('django.db.models.fields.CharField')(max_length=150)),
            ('description', self.gf('django.db.models.fields.TextField')(default='')),
            ('element_type', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['contenttypes.ContentType'])),
            ('object_id', self.gf('django.db.models.fields.PositiveIntegerField')()),
        ))
        db.send_create_signal('courses', ['Element'])

        # Adding unique constraint on 'Element', fields ['part', 'num']
        db.create_unique('courses_element', ['part_id', 'num'])


    def backwards(self, orm):
        
        # Removing unique constraint on 'Element', fields ['part', 'num']
        db.delete_unique('courses_element', ['part_id', 'num'])

        # Removing unique constraint on 'Part', fields ['course', 'num']
        db.delete_unique('courses_part', ['course_id', 'num'])

        # Deleting model 'Course'
        db.delete_table('courses_course')

        # Removing M2M table for field managers on 'Course'
        db.delete_table('courses_managers')

        # Deleting model 'Enrollment'
        db.delete_table('courses_enrollment')

        # Deleting model 'Application'
        db.delete_table('courses_application')

        # Deleting model 'Certificate'
        db.delete_table('courses_certificate')

        # Deleting model 'Part'
        db.delete_table('courses_part')

        # Deleting model 'Element'
        db.delete_table('courses_element')


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
        'courses.application': {
            'Meta': {'object_name': 'Application'},
            'course': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['courses.Course']"}),
            'date_submitted': ('django.db.models.fields.DateField', [], {}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"})
        },
        'courses.certificate': {
            'Meta': {'object_name': 'Certificate'},
            'course': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['courses.Course']"}),
            'date_enrolled': ('django.db.models.fields.DateField', [], {}),
            'date_finished': ('django.db.models.fields.DateField', [], {}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'rating': ('django.db.models.fields.DecimalField', [], {'max_digits': '5', 'decimal_places': '2'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"})
        },
        'courses.course': {
            'Meta': {'object_name': 'Course'},
            'active': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'description': ('django.db.models.fields.TextField', [], {'default': "''"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'managers': ('django.db.models.fields.related.ManyToManyField', [], {'related_name': "'courses_managing'", 'symmetrical': 'False', 'db_table': "'courses_managers'", 'to': "orm['auth.User']"}),
            'students': ('django.db.models.fields.related.ManyToManyField', [], {'related_name': "'courses_learning'", 'symmetrical': 'False', 'through': "orm['courses.Enrollment']", 'to': "orm['auth.User']"}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '150'})
        },
        'courses.element': {
            'Meta': {'unique_together': "(('part', 'num'),)", 'object_name': 'Element'},
            'description': ('django.db.models.fields.TextField', [], {'default': "''"}),
            'element_type': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['contenttypes.ContentType']"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'num': ('django.db.models.fields.IntegerField', [], {}),
            'object_id': ('django.db.models.fields.PositiveIntegerField', [], {}),
            'part': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['courses.Part']"}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '150'})
        },
        'courses.enrollment': {
            'Meta': {'object_name': 'Enrollment'},
            'course': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['courses.Course']"}),
            'date_enrolled': ('django.db.models.fields.DateField', [], {}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'user': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['auth.User']"})
        },
        'courses.part': {
            'Meta': {'unique_together': "(('course', 'num'),)", 'object_name': 'Part'},
            'course': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['courses.Course']"}),
            'description': ('django.db.models.fields.TextField', [], {'default': "''"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'num': ('django.db.models.fields.IntegerField', [], {}),
            'title': ('django.db.models.fields.CharField', [], {'max_length': '150'})
        }
    }

    complete_apps = ['courses']
