from django.db import models
from django.contrib.auth.models import User



class Category(models.Model):
    title   = models.CharField(max_length=100)
    date    = models.DateField(auto_now_add=True)

    def __str__(self):
        return self.title


class Product(models.Model):
    title           = models.CharField(max_length=100)
    data            = models.DateField(auto_now_add=True)
    category        = models.ForeignKey(Category, on_delete=models.CASCADE)
    image           = models.ImageField(upload_to="products/")
    marcket_price   = models.PositiveIntegerField()
    selling_price   = models.PositiveIntegerField()
    description     = models.TextField()

    def __str__(self):
        return self.title


class cat1(models.Model):
    product     = models.ForeignKey(Product, on_delete=models.CASCADE)
    user         = models.ForeignKey(User, on_delete=models.CASCADE)
    iscat1    = models.BooleanField(default=False)

    def __str__(self):
        return f"productID ={self.product.id}user={self.user.username}|ISB1={self.iscat1}"


class cat2(models.Model):
    product      = models.ForeignKey(Product, on_delete=models.CASCADE)
    user         = models.ForeignKey(User, on_delete=models.CASCADE)
    iscat2   = models.BooleanField(default=False)

    def __str__(self):
        return f"productID ={self.product.id}user={self.user.username}|IScat2={self.iscat2}"


class cat3(models.Model):
    product      = models.ForeignKey(Product, on_delete=models.CASCADE)
    user         = models.ForeignKey(User, on_delete=models.CASCADE)
    iscat3   = models.BooleanField(default=False)

    def __str__(self):
        return f"productID ={self.product.id}user={self.user.username}|IScat3={self.iscat3}"



class Cart(models.Model):
    user        = models.ForeignKey(User, on_delete=models.CASCADE)
    total       = models.PositiveIntegerField()
    isComplit   = models.BooleanField(default=False)
    date        = models.DateField(auto_now_add=True)

    def __str__(self):
        return f"User={self.user.username}|ISComplit={self.isComplit}"


class CartProduct(models.Model):
    cart      = models.ForeignKey(Cart, on_delete=models.CASCADE)
    product   = models.ManyToManyField(Product)
    price     = models.PositiveIntegerField()
    quantity  = models.PositiveIntegerField()
    subtotal  = models.PositiveIntegerField()

    def __str__(self):
        return f"Cart=={self.cart.id}<==>CartProduct:{self.id}==Qualtity=={self.quantity}"


class Order(models.Model):
    cart        = models.OneToOneField(Cart, on_delete=models.CASCADE)
    email       = models.EmailField(max_length=150)
    phone       = models.CharField(max_length=13)
    address     = models.CharField(max_length=200)