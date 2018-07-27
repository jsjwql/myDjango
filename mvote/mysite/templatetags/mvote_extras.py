from django import template
from mysite import models

#产生一个注册用的对象 register
register = template.Library()

#使用修饰词 @register.filter 的方法把自定义标签注册成模板语言标签的一部分
@register.filter(name='show_items')
def show_items(value):
    try:
        poll = models.Poll.objects.get(id=int(value))
        items = models.PollItem.objects.filter(poll=poll).count()
    except:
        items = 0
    return items

@register.filter(name='show_votes')
def show_votes(value):
    try:
        poll = models.Poll.objects.get(id=int(value))
        votes = 0
        pollitems = models.PollItem.objects.filter(poll=poll)
        for pollitem in pollitems:
            votes = votes + pollitem.vote
    except:
        votes = 0
    return votes