#_*_ coding: utf-8 _*_
from django import forms
from mysite import models

class OrderForm(forms.ModelForm):
    class Meta:
        model = models.Order
        fields = ['full_name', 'address', 'phone']
    def __init__(self, *args, **kwargs):
        super(OrderForm, self).__init__(*args, **kwargs)
        self.fields['full_name'].label = '收件人姓名'
        self.fields['address'].label = '邮寄地址'
        self.fields['phone'].label = '联络电话'