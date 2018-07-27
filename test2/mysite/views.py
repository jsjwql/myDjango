from django.shortcuts import render
from django.template.loader import get_template
from datetime import datetime
from django.http import HttpResponse

# Create your views here.

def index(request, tvno='0'):
    tv_list = [{'name': 'CCTV 中文国际', 'tvcode': 'vCDDYb_M2B4'},
               {'name': '华语流行音乐电台', 'tvcode': 'fAxvohHQF2s'},]
    template = get_template('index.html')
    now = datetime.now()
    hour = now.timetuple().tm_hour
    tvno = tvno
    tv = tv_list[int(tvno)]
    html = template.render(locals())
    return HttpResponse(html)

def engtv(reqeust, tvno='0'):
    tv_list = [{'name':'SkyNews', 'tvcode':'XOacA3RYrXk'},
               {'name':'Al Jazeera English', 'tvcode':'XbZjFCGZ1Mc'},
               {'name':'CNN News18 LIVE Streaming', 'tvcode':'5nHKlZjbql8'},
               {'name':'CCTV', 'tvcode':'vCDDYb_M2B4'},]
    template = get_template('engtv.html')
    now = datetime.now()
    tvno = tvno
    tv = tv_list[int(tvno)]
    html = template.render(locals())
    return HttpResponse(html)

def carlist(request, maker=0):
    car_maker = ['SAAB', 'Ford', 'Honda', 'Mazda', 'Nissan', 'Toyota']
    car_list = [ [],
                 ['Fiesta', 'Focus', 'Modeo', 'EcoSport', 'Kuga', 'Mustang'],
                 ['Fit', 'Odyssey', 'CR-V', 'City', 'NSX'],
                 ['Mazda3', 'Mazda3', 'Mazda6', 'CX-3', 'CX-5', 'MX-5'],
                 ['Tida', 'March', 'Livina', 'Sentra', 'Teana', 'X-Trail', 'Wish'],
                 ['Camry', 'Altis', 'Yaris', '86', 'Prius', 'Vios', 'RAV4','Wish']
                 ]
    maker = int(maker)
    maker_name = car_maker[maker]
    cars = car_list[maker]
    template = get_template('carlist.html')
    html = template.render(locals())

    return HttpResponse(html)

def carprice(request, maker=0):
    car_maker = ['Ford', 'Honda', 'Mazda']
    car_list = [[   {'model':'Fiesta', 'price':203500},
                    {'model':'Focus', 'price':405000},
                    {'model':'Mustang','price':900000}],
                [   {'model':'Fit','price':450000},
                    {'model':'City','price':150000},
                    {'model':'NSX','price':1200000}],
                [   {'model':'Mazda3','price':329999},
                    {'model':'Mazda5','price':603000},
                    {'model':'Mazda6','price':850000}],
                ]
    maker = int(maker)
    maker_name = car_maker[maker]
    cars = car_list[maker]
    template = get_template('carprice.html')
    html = template.render(locals())

    return HttpResponse(html)