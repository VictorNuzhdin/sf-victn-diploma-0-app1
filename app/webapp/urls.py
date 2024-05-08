"""webapp URL Configuration
"""
from django.contrib import admin
from django.urls import path
from django.urls import include, path
from . import views

urlpatterns = [
    #path('', views.index, name='index'),
    #path('hello/', include('greetings.urls')),
    path('/', include('greetings.urls')),
    path('/bonus/', include('bonus.urls')),
    #path('bonus/', include('bonus.urls')),
    #path('admin/', admin.site.urls),
]

# example1
#   URL1:
#       http://192.168.0.71:8000
#   OUT1: 
#       Index page
#
#   URL2:
#       http://192.168.0.71:8000/hello
#   OUT2: 
#       Hello page
#
