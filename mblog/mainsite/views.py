from django.shortcuts import render, redirect
from django.http import HttpResponse
from mainsite.models import Post
from django.template.loader import get_template
from datetime import datetime
from django.shortcuts import get_object_or_404
# Create your views here.

def homepage(request):
    template = get_template('index.html')
    posts = Post.objects.all()
    now = datetime.now()
    html = template.render(locals())
    return HttpResponse(html)

def showpost(request, slug):
    template = get_template('post.html')
    try:
        post = Post.objects.get(pk = slug)      #这里应该为 pk，而不是 slug
        if post != None:
            html = template.render(locals())
            return HttpResponse(html)
    except:
        return redirect('/')