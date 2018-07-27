from django.http import HttpResponse, Http404
from django.template.loader import get_template
import random
from mysite.models import Product

def index(request):
    template = get_template('index.html')
    quotes = ['今日事，今日毕',
              '要收获先付出',
              '知识就是力量',
              '一个人的个性就是他的命运']
    html = template.render({'quote': random.choice(quotes)})
    return HttpResponse(html)

def about(request):
    template = get_template('about.html')
    html = template.render()
    return HttpResponse(html)

def listing(request):
    products = Product.objects.all()
    tempalte = get_template('list.html')
    html = tempalte.render({'products': products})
    return HttpResponse(html)

def disp_detail(request, sku):
    try:
        products = Product.objects.get(sku=sku)
    except Product.DoesNotExist:
        raise Http404('找不到指定的产品编号')
    template = get_template('disp.html')
    html = template.render({'products': products})
    return HttpResponse(html)