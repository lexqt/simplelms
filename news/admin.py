from django.contrib import admin
from django.db import models
from .models import Article
from tinymce.widgets import TinyMCE

class ArticleAdmin(admin.ModelAdmin):
    date_hierarchy = 'created'
    formfield_overrides = {
        models.TextField: {'widget': TinyMCE},
    }
    list_display       = ('id', 'title', 'published', 'created', 'author')
    list_display_links = ('id', 'title')
    list_editable      =                ('published',)
    list_filter        =                ('published', 'created', 'author')
    search_fields      =        ['title']
    list_per_page = 20

admin.site.register(Article, ArticleAdmin)
