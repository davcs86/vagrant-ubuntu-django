from django.conf.urls import include, url
from django.contrib import admin

__author__ = 'davcs86'


urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),
    url(r'^', include('todo.urls')),
]
