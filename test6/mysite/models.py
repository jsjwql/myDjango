from django.db import models
from django.contrib.auth.models import User
# Create your models here.

#user = User.objects.create_user('管理员', 'xxx@xxx.com', '123')

# class User(models.Model):
#     name = models.CharField(max_length=20, null=False)
#     email = models.EmailField()
#     password = models.CharField(max_length=20, null=False)
#     enabled = models.BooleanField(default=False)
#
#     def __str__(self):
#         return self.name

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    height = models.PositiveIntegerField(default=160)
    male = models.BooleanField(default=False)
    website = models.URLField(null=True)

    def str(self):
        return self.user.username

class Diary(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    budget = models.FloatField(default=0)
    weight = models.FloatField(default=0)
    note = models.TextField()
    ddate = models.DateField()

    def __str__(self):
        return '{}({})'.format(self.ddate, self.user)