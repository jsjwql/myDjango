# -*- coding: utf-8 -*-
import datetime

from allauth.account.decorators import verified_email_required
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.core.mail import send_mail
from django.template.loader import get_template
from django.http import HttpResponse
from django.shortcuts import redirect
from django.views.decorators.csrf import csrf_exempt

from mysite import models, forms
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from cart.cart import Cart
from django.conf import settings
from paypal.standard.forms import PayPalPaymentsForm
from django.core.urlresolvers import reverse
# Create your views here.

# 主页面
def index(request, cat_id='0'):
    all_categories = models.Category.objects.all()
    all_products = None
    # 其中 cat_id 得是 str 类型，不能为 int，因为网址中显示的为 str。
    if cat_id>'0':
        try:
            category = models.Category.objects.get(id=cat_id)
        except:
            category = None

        if category is not None:
            all_products = models.Product.objects.filter(category=category)

    if all_products is None:
        all_products = models.Product.objects.all()

    paginator = Paginator(all_products, 4)
    p = request.GET.get('p')
    try:
        products = paginator.page(p)
    except PageNotAnInteger:
        products = paginator.page(1)
    except EmptyPage:
        products = paginator.page(paginator.num_pages)

    template = get_template('index.html')
    html = template.render(context=locals(), request=request)
    return HttpResponse(html)

# 产品详情页
def product(request, product_id):

    try:
        product = models.Product.objects.get(id=product_id)
    except:
        product = None

    template = get_template('product.html')
    html = template.render(context=locals(), request=request)
    return HttpResponse(html)

# 添加购物车
def add_to_cart(request, product_id, quantity):
    product = models.Product.objects.get(id=product_id)
    cart = Cart(request)
    cart.add(product, product.price, quantity)
    return redirect('/')

# 移除购物车内容
def remove_from_cart(request, product_id):
    product = models.Product.objects.get(id=product_id)
    cart = Cart(request)
    cart.remove(product)
    return redirect('/cart/')

# 购物车内容
@login_required
def cart(request):
    all_categories = models.Category.objects.all()
    cart = Cart(request)
    template = get_template('cart.html')
    html = template.render(context=locals(), request=request)
    return HttpResponse(html)

# 处理订单信息
@verified_email_required
def order(request):
    all_categories = models.Category.objects.all()
    cart = Cart(request)
    if request.method == 'POST':
        user = User.objects.get(username=request.user.username)
        new_order = models.Order(user=user)

        form = forms.OrderForm(request.POST, instance=new_order)
        if form.is_valid():
            order = form.save()
            email_messages = "您的购物內容如下：\n"
            for item in cart:
                models.OrderItem.objects.create(order=order,
                                          product=item.product,
                                          price = item.product.price,
                                          quantity=item.quantity)
                email_messages = email_messages + "\n" + \
                                "{}, {}, {}".format(item.product, item.product.price, item.quantity)
            email_messages = email_messages + \
                    "\n以上共计{}元\nhttp://127.0.0.1:8000/感谢您的订购！".format(cart.summary())
            messages.add_message(request, messages.INFO, "订单已储存，我們会尽快处理。")
            send_mail("感谢您的订购",
                       email_messages,
                       '迷你小电商<weixuqinhd@gmail.com>',
                       [request.user.email],)
            send_mail("有人订购商品呦",
                       email_messages,
                       '迷你小电商<weixuqinhd@gmail.com>',
                       ['weixuqinhd@gmail.com'],)
            cart.clear()
            return redirect('/myorders/')
    else:
        form = forms.OrderForm()

    template = get_template('order.html')
    html = template.render(context=locals(), request=request)
    return HttpResponse(html)

# 显示当前用户信息
@login_required
def my_orders(request):
    all_categories = models.Category.objects.all()
    # 显示当前用户订单信息
    orders = models.Order.objects.filter(user=request.user)

    template = get_template('myorders.html')
    html = template.render(context=locals(), request=request)
    return HttpResponse(html)

# 付款完成
@csrf_exempt    #csrf 验证
def payment_done(request):
    template = get_template('payment_done.html')
    html = template.render(context=locals(), request=request)
    return HttpResponse(html)

# 取消付款
@csrf_exempt
def payment_canceled(request):
    template = get_template('payment_canceled.html')
    html = template.render(context=locals(), request=request)
    return HttpResponse(html)

# PayPal 付款操作，建立正确的付款按钮
@login_required
def payment(request, order_id):
    all_categories = models.Category.objects.all()
    try:
        order = models.Order.objects.get(id=order_id)
    except:
        messages.add_message(request, messages.WARNING, "订单编号错误，无法处理付款。")
        return redirect('/myorders/')
    all_order_items = models.OrderItem.objects.filter(order=order)
    items = list()
    total = 0
    for order_item in all_order_items:
        t = dict()
        t['name'] = order_item.product.name
        t['price'] = order_item.product.price
        t['quantity'] = order_item.quantity
        t['subtotal'] = order_item.product.price * order_item.quantity
        total = total + order_item.product.price
        items.append(t)

    host = request.get_host()
    paypal_dict = {
        "business": settings.PAYPAL_REVEIVER_EMAIL,
        "amount": total,
        "item_name": "迷你小电商商品编号:{}".format(order_id),
        "invoice": "invoice-{}".format(order_id),
        "currency_code": 'CNY',
        "notify_url": "http://{}{}".format(host, reverse('paypal-ipn')),
        "return_url": "http://{}/done/".format(host),
        "cancel_return": "http://{}/canceled/".format(host),
        }
    paypal_form = PayPalPaymentsForm(initial=paypal_dict)
    template = get_template('payment.html')
    html = template.render(context=locals(), request=request)
    return HttpResponse(html)
