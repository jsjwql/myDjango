# 处理 paypal 返回的 http 数据，更改数据库内容
from mysite import models
from paypal.standard.models import ST_PP_COMPLETED, ST_PP_PENDING
from paypal.standard.ipn.signals import valid_ipn_received

def payment_notification(sender, **kwargs):
    ipn_obj = sender
    if ipn_obj.payment_status == ST_PP_PENDING:
        order_id = ipn_obj.invoice.split('-')[-1]
        order = models.Order.objects.get(id = order_id)
        order.paid = True
        order.save()

valid_ipn_received.connect(payment_notification)