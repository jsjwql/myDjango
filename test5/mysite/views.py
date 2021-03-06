# _*_ encoding:utf-8 _*_
from django.template.loader import get_template
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import redirect
from django.contrib import messages
from mysite import models, forms
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.contrib import auth
from django.contrib.auth.decorators import login_required
# Create your views here.

def index(request, pid=None, del_pass=None):
    if request.user.is_authenticated:
        username = request.user.username
        useremail = request.user.email
        try:
            user = models.User.objects.get(username = username)
            diaries = models.Diary.objects.filter(user=user).order_by('-ddate')
        except:
            pass
    messages.get_messages(request)

    template = get_template('index.html')
    html = template.render(context=locals(), request=request)
    return HttpResponse(html)

def login(request):
    if request.method == 'POST':
        login_form = forms.LoginForm(request.POST)
        if login_form.is_valid():
            login_name = request.POST['username'].strip()
            login_passname = request.POST['password']
            user = authenticate(username=login_name, password=login_passname)
            if user is not None:
                if user.is_active:
                    auth.login(request, user)
                    print('success')
                    messages.add_message(request, messages.SUCCESS, '成功登录了')
                    return redirect('/')
                else:
                    messages.add_message(request, messages.WARNING, '账号尚未启用')
            else:
                messages.add_message(request, messages.WARNING, '登录失败')
        else:
            messages.add_message(request, messages.INFO, '请检查输入的字段内容')
    else:
        login_form = forms.LoginForm()

    template = get_template('login.html')
    html = template.render(context=locals(), request=request)
    response = HttpResponse(html)
    return response



def logout(request):
    auth.logout(request)
    messages.add_message(request, messages.INFO, '成功注销了')
    return redirect('/')

@login_required(login_url='/login/')
def userinfo(request):
    if request.user.is_authenticated:
        username = request.user.username
        try:
            user = User.objects.get(username=username)
            userinfo = models.Profile.objects.get(user=user)
        except:
            pass
    template = get_template('userinfo.html')
    html = template.render(locals())
    return HttpResponse(html)


@login_required(login_url='/login/')
def posting(request):
    if request.user.is_authenticated:
        username = request.user.username
        useremail = request.user.email
    messages.get_messages(request)

    if request.method == 'POST':
        user = User.objects.get(username=username)
        diary = models.Diary(user=user)
        post_form = forms.DiaryForm(request.POST, instance=diary)
        if post_form.is_valid():
            messages.add_message(request, messages.INFO, "日记已保存")
            post_form.save()
            return HttpResponseRedirect('/')
        else:
            messages.add_message(request, messages.INFO, '要张贴日记，每一个字段都要填...')
    else:
        post_form = forms.DiaryForm()
        messages.add_message(request, messages.INFO, '要张贴日记，每一个字段都要填...')

    template = get_template('posting.html')
    html = template.render(context=locals(), request=request)
    return HttpResponse(html)


