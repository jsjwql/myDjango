from django.shortcuts import render
from django.template.loader import get_template
from django.http import HttpResponse, HttpResponseRedirect
from django.core.mail import send_mail
from mysite import models, forms
# Create your views here.

def index(request, pid=None, del_pass=None):
    template = get_template('index.html')
    posts = models.Post.objects.filter(enabled=True).order_by('-pub_time')[:30]
    moods = models.Mood.objects.all()

    try:
        user_id = request.GET['user_id']
        user_pass = request.GET['user_pass']
        user_post = request.GET['user_post']
        user_mood = request.GET['mood']
    except:
        user_id = None
        message = '如果要张贴信息，那么每一个字段都要填'

    if del_pass and pid:
        try:
            post = models.Post.objects.get(id=pid)
        except:
            post = None
        if post:
            if post.del_pass == del_pass:
                post.delete()
                message = '数据删除成功'
    elif user_id != None:
        mood = models.Mood.objects.get(status=user_mood)
        post = models.Post.objects.create(mood=mood, nickname=user_id, del_pass=user_pass, message=user_post)
        post.save()
        message = '成功存储！请记得您的编辑密码[{}], 信息须经过审查后才会显示。'.format(user_pass)
    html = template.render(locals())
    return HttpResponse(html)

def listing(request):
    template = get_template('listing.html')
    posts = models.Post.objects.filter(enabled=True).order_by('-pub_time')[:150]
    moods = models.Mood.objects.all()

    html = template.render(locals())

    return HttpResponse(html)

def posting(request):
    template = get_template('posting.html')
    moods = models.Mood.objects.all()
    message = '如要张贴信息，则每一个字段都要填...'
    html = template.render(context=locals(), request=request)

    return HttpResponse(html)

def contact(request):
    if request.method == 'POST':
        form = forms.ContactForm(request.POST)
        if form.is_valid():
            message = '感谢您的来信，我们会尽快处理您的宝贵意见。'
            user_name = form.cleaned_data['user_name']
            user_city = form.cleaned_data['user_city']
            user_school = form.cleaned_data['user_school']
            user_email = form.cleaned_data['user_email']
            user_message = form.cleaned_data['user_message']

            mail_body = '''
                        网友姓名：{}
                        居住城市：{}
                        是否在学：{}
                        反映意见：如下
                        {}
                        '''.format(user_name, user_city, user_school, user_message)
            send_mail('来自【不吐不快】网站的网友意见',
                        mail_body,
                        user_email,
                        ['weixuqinhd@gmail.com'])
        else:
            message = '请检查您输入的信息是否正确!'
    else:
        form = forms.ContactForm()

    template = get_template('contact.html')
    html = template.render(context=locals(), request=request)

    return HttpResponse(html)

def post2db(request):
    if request.method == 'POST':
        post_form = forms.PostForm(request.POST)
        if post_form.is_valid():
            message = '您的信息已存储，要等管理员启用后才看得到。'
            post_form.save()
            return HttpResponseRedirect('/list')
        else:
            message = '如果要张贴信息，那么每一个字段都要填...'
    else:
        post_form = forms.PostForm()
        message = '如果要张贴信息，那么每一个字段都要填...'

    template = get_template('post2db.html')
    html = template.render(context=locals(), request=request)

    return HttpResponse(html)


