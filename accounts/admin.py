# coding: utf-8

from django.contrib import admin
from django.contrib import auth
from django.contrib.auth.models import User
from accounts.models import UserProfile

class UserProfileInline(admin.TabularInline):
    model = UserProfile
    
    def get_readonly_fields(self, request, obj=None):
        if request.user.is_superuser:
            return super(UserProfileInline, self).get_readonly_fields(request, obj)
        
        if obj is None:
            return tuple()
        else:
            return ('middle_name',)



class UserAdmin(auth.admin.UserAdmin):
    
    list_display  = ('username', 'email', 'last_name', 'first_name', 'middle_name', 'is_staff', 'is_active', 'date_joined')
    list_filter   =                                                                ('is_staff', 'is_active', 'date_joined')

    search_fields = ('username', 'email', 'last_name', 'first_name', 'profile__middle_name')
    
    date_hierarchy =   'date_joined'
    ordering       = ('-date_joined', 'username')
    
    list_per_page = 20
    inlines = [UserProfileInline]
    
    def change_view(self, request, object_id, extra_context=None):
        if not request.user.is_superuser:
            self.exclude = ('password',)
            # see auth.admin.UserAdmin.fieldsets
            self.fieldsets[0][1]['fields'] = ('username',)
        return super(UserAdmin, self).change_view(request, object_id, extra_context)
    
    def middle_name(self, obj):
        return obj.profile.middle_name
    middle_name.short_description = 'отчество'
    middle_name.admin_order_field = 'profile__middle_name'
    
    def get_readonly_fields(self, request, obj=None):
        if request.user.is_superuser:
            return super(UserAdmin, self).get_readonly_fields(request, obj)
        
        if obj is None:
            return tuple()
        else:
            return ('username', 'first_name', 'last_name',
                    'email', 'password',
                    'is_staff', 'is_active', 'is_superuser',
                    'last_login', 'date_joined',
                    'groups', 'user_permissions')
    
    def queryset(self, request):
        qs = super(UserAdmin, self).queryset(request).select_related('profile')
        if request.user.is_superuser:
            return qs
        return qs.filter(groups__name__in=('newcomers', 'students'))



admin.site.unregister(User)
admin.site.register(User, UserAdmin)
