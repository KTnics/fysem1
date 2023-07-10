from django.contrib import admin
from .models import Cart, Product, CartProduct, Category, Order, cat1,cat2,cat3


admin.site.register([Cart, Product, CartProduct, Category, Order, cat1,cat2,cat3 ])
