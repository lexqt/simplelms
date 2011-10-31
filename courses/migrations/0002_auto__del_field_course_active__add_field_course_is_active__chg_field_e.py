# encoding: utf-8
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models

class Migration(SchemaMigration):

    def forwards(self, orm):
        
        # Deleting field 'Course.active'
        db.delete_column('courses_course', 'active')

        # Adding field 'Course.is_active'
        db.add_column('courses_course', 'is_active', self.gf('django.db.models.fields.BooleanField')(default=False), keep_default=False)

        # Changing field 'Enrollment.date_enrolled'
        db.alter_column('courses_enrollment', 'date_enrolled', self.gf('django.db.models.fields.DateField')(auto_now_add=True))

        # Changing field 'Application.date_submitted'
        db.alter_column('courses_application', 'date_submitted', self.gf('django.db.models.fields.DateField')(auto_now_add=True))


    def backwards(self, orm):
        
        # Adding field 'Course.active'
        db.add_column('courses_course', 'active', self.gf('django.db.models.fields.BooleanField')(default=False), keep_default=False)

        # Deleting field 'Course.is_active'
        db.delete_column('courses_course', 'is_active')

        # Changing field 'Enrollment.date_enrolled'
        db.alter_column('courses_enrollment', 'date_enrolled', self.gf('django.db.models.fields.DateField')())

        # Changing field 'Application.date_submitted'
        db.alter_column('courses_application', 'date_submitted', self.gf('django.db.models.fields.DateField')())


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
            'date_submitted': ('django.db.models.fields.DateField', [], {'auto_now_add': 'True', 'blank': 'True'}),
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
            'description': ('django.db.models.fields.TextField', [], {'default': "''"}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'is_active': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
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
            'date_enrolled': ('django.db.models.fields.DateField', [], {'auto_now_add': 'True', 'blank': 'True'}),
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
