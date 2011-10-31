# coding: utf-8

from django.http import HttpResponseRedirect

def logout_view(request):
    from django.contrib.auth import logout
    logout(request)
    return HttpResponseRedirect('/')


def login_view(request):
    if request.user.is_authenticated():
        return HttpResponseRedirect('/')
    
    from django.contrib.auth.views import login
    return login(request, template_name='login.html')
#    from django.contrib.auth import authenticate, login
#    username = request.POST['username']
#    password = request.POST['password']
#    user = authenticate(username=username, password=password)
#    if user is not None:
#        if user.is_active:
#            login(request, user)
#            # Redirect to a success page.
#        else:
#            # Return a 'disabled account' error message
#    else:
#        # Return an 'invalid login' error message.

def register_view(request):
    from django.shortcuts import render
    from django.contrib.auth.models import Group
    from .forms import UserForm, UserProfileForm
    if request.method == 'POST':
        user_form    = UserForm(request.POST)
        profile_form = UserProfileForm(request.POST)
        if user_form.is_valid() and profile_form.is_valid():
            user    = user_form.save()
            profile = profile_form.save(commit = False)
            profile.user = user
            profile.save()
            g = Group.objects.get(name='newcomers')
            g.user_set.add(user)
            from django.contrib import messages
            messages.success(request, 'Учетная запись успешно создана. Теперь можете зайти на сайт.')
            return HttpResponseRedirect('login')
    else:
        user_form    = UserForm()
        profile_form = UserProfileForm()
    
    return render(request, 'register.html', {
        'user_form': user_form,
        'profile_form': profile_form,
        }
    )
