# -*- coding: utf-8 -*-

from django import forms
from mysite import models
from captcha.fields import CaptchaField

class ContactForm(forms.Form):
    CITY = [
        ['BJ', 'Beijing'],
        ['SH', 'Shanghai'],
        ['GZ', 'Guangzhou'],
        ['SZ', 'Shenzhen'],
        ['MZ', 'Meizhou'],
        ['NA', 'Others'],
    ]
    user_name = forms.CharField(label='您的名字', max_length=50, initial='小可爱~')
    user_city = forms.ChoiceField(label='居住城市', choices=CITY)
    user_school = forms.BooleanField(label='是否在学', required=False)
    user_email = forms.EmailField(label='电子邮件')
    user_message = forms.CharField(label='您的意见', widget=forms.Textarea)

class PostForm(forms.ModelForm):
    captcha = CaptchaField()
    class Meta:
        model = models.Post
        fields = ['mood', 'nickname', 'message', 'del_pass']

    def __init__(self, *args, **kwargs):
        super(PostForm, self).__init__(*args, **kwargs)
        self.fields['mood'].label = '现在的心情'
        self.fields['nickname'].label = '您的昵称'
        self.fields['message'].label = '心情留言'
        self.fields['del_pass'].label = '设置密码'
        self.fields['captcha'].label = '请输入验证码'

