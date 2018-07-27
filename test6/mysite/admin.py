from django.contrib import admin
from mysite import models
# Register your models here.

admin.site.register(models.Profile)
admin.site.register(models.Diary)