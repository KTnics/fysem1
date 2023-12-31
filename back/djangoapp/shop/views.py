from .serializer import *
from .models import *
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication


class ProductView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        query = Product.objects.all()
        data = []
        serializers = ProductSerializer(query, many=True)
        for product in serializers.data:
            fab_query = cat1.objects.filter(
                user=request.user).filter(product__id=product['id'])
            if fab_query:
                product['cat1'] = fab_query[0].iscat1
            else:
                product['cat1'] = False


        for product in serializers.data:
            fab_query = cat2.objects.filter(
                user=request.user).filter(product__id=product['id'])
            if fab_query:
                product['cat2'] = fab_query[0].iscat2
            else:
                product['cat2'] = False


        for product in serializers.data:
            fab_query = cat3.objects.filter(
                user=request.user).filter(product__id=product['id'])
            if fab_query:
                product['cat3'] = fab_query[0].iscat3
            else:
                product['cat3'] = False                
            data.append(product)
        return Response(data)

  
class B1View(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        data = request.data["id"]
        # print(data)
        try:
            book_obj = Product.objects.get(id=data)
            # print(data)
            user = request.user
            B1_book = cat1.objects.filter(
                user=user).filter(book=book_obj).first()
            if B1_book:
                print("cat1_book")
                abc = B1_book.iscat1
                B1_book.iscat1 = not abc
                B1_book.save()
            else:
                cat1.objects.create(
                    book=book_obj, user=user, isB1=True)
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)








  
class B2View(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        data = request.data["id"]
        # print(data)
        try:
            book_obj = Product.objects.get(id=data)
            # print(data)
            user = request.user
            B2_book = cat2.objects.filter(
                user=user).filter(book=book_obj).first()
            if B2_book:
                print("cat1_book")
                abc = B2_book.iscat2
                B2_book.iscat2 = not abc
                B2_book.save()
            else:
                cat2.objects.create(
                    book=book_obj, user=user, iscat2=True)
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)








  
class B3View(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        data = request.data["id"]
        # print(data)
        try:
            book_obj = Product.objects.get(id=data)
            # print(data)
            user = request.user
            B3_book = cat3.objects.filter(
                user=user).filter(book=book_obj).first()
            if B3_book:
                print("cat3_book")
                abc = B3_book.iscat3
                B3_book.iscat3 = not abc
                B3_book.save()
            else:
                cat3.objects.create(
                    book=book_obj, user=user, iscat3=True)
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)



















#class FavoritView(APIView):
 #   permission_classes = [IsAuthenticated, ]
  #  authentication_classes = [TokenAuthentication, ]

   # def post(self, request):
    #    data = request.data["id"]
        # print(data)
     #   try:
      #      product_obj = Product.objects.get(id=data)
       #     # print(data)
        #    user = request.user
         #   single_favorit_product = a1.objects.filter(
          #      user=user).filter(product=product_obj).first()
           # if single_favorit_product:
            ##   ccc = single_favorit_product.isFavorit
              #  single_favorit_product.isFavorit = not ccc
               # single_favorit_product.save()
            #else:
             #   a1.objects.create(
              #      product=product_obj, user=user, isFavorit=True)
            #response_msg = {'error': False}
        #except:
         #   response_msg = {'error': True}
        #return Response(response_msg)


class RegisterView(APIView):
    def post(self, request):
        serializers = Userserializer(data=request.data)   
        if serializers.is_valid():
            serializers.save()
            return Response({"error": False})
        return Response({"error": True})



class CartView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]
  
    def get(self, request):
        user = request.user
        try:
            cart_obj = Cart.objects.filter(user=user).filter(isComplit=False)
            data = []
            cart_serializer = CartSerializers(cart_obj, many=True)
            for cart in cart_serializer.data:
                cart_product_obj = CartProduct.objects.filter(cart=cart["id"])
                cart_product_obj_serializer = CartProductSerializers(
                    cart_product_obj, many=True)
                cart['cartproducts'] = cart_product_obj_serializer.data
                data.append(cart)
            response_msg = {"error": False, "data": data}
        except:
            response_msg = {"error": True, "data": "No Data"}
        return Response(response_msg)


class OrderView(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        try:
            query = Order.objects.filter(cart__user=request.user)
            serializers = OrdersSerializers(query, many=True)
            response_msg = {"error": False, "data": serializers.data}
        except:
            response_msg = {"error": True, "data": "no data"}
        return Response(response_msg)


class AddToCart(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        product_id = request.data['id']
        product_obj = Product.objects.get(id=product_id)
        # print(product_obj, "product_obj")
        cart_cart = Cart.objects.filter(
            user=request.user).filter(isComplit=False).first()
        cart_product_obj = CartProduct.objects.filter(
            product__id=product_id).first()

        try:
            if cart_cart:
                print(cart_cart)
                print("OLD CART")
                this_product_in_cart = cart_cart.cartproduct_set.filter(
                    product=product_obj)
                if this_product_in_cart.exists():
                    cartprod_uct = CartProduct.objects.filter(
                        product=product_obj).filter(cart__isComplit=False).first()
                    cartprod_uct.quantity += 1
                    cartprod_uct.subtotal += product_obj.selling_price
                    cartprod_uct.save()
                    cart_cart.total += product_obj.selling_price
                    cart_cart.save()
                else:
                    print("NEW CART PRODUCT CREATED--OLD CART")
                    cart_product_new = CartProduct.objects.create(
                        cart=cart_cart,
                        price=product_obj.selling_price,
                        quantity=1,
                        subtotal=product_obj.selling_price
                    )
                    cart_product_new.product.add(product_obj)
                    cart_cart.total += product_obj.selling_price
                    cart_cart.save()
            else:
                Cart.objects.create(user=request.user,
                                    total=0, isComplit=False)
                new_cart = Cart.objects.filter(
                    user=request.user).filter(isComplit=False).first()
                cart_product_new = CartProduct.objects.create(
                    cart=new_cart,
                    price=product_obj.selling_price,
                    quantity=1,
                    subtotal=product_obj.selling_price
                )
                cart_product_new.product.add(product_obj)
                new_cart.total += product_obj.selling_price
                new_cart.save()
            response_mesage = {
                'error': False, 'message': "Product add to card successfully", "productid": product_id}
        except:
            response_mesage = {'error': True,
                               'message': "Product Not add!Somthing is Wromg"}
        return Response(response_mesage)


class DelateCarProduct(APIView):
    authentication_classes = [TokenAuthentication, ]
    permission_classes = [IsAuthenticated, ]

    def post(self, request):
        cart_product_id = request.data['id']
        try:
            cart_product_obj = CartProduct.objects.get(id=cart_product_id)
            cart_cart = Cart.objects.filter(
                user=request.user).filter(isComplit=False).first()
            cart_cart.total -= cart_product_obj.subtotal
            cart_product_obj.delete()
            cart_cart.save()
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)


class DelateCart(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        cart_id = request.data['id']
        try:
            cart_obj = Cart.objects.get(id=cart_id)
            cart_obj.delete()
            response_msg = {'error': False}
        except:
            response_msg = {'error': True}
        return Response(response_msg)


class OrderCreate(APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(self, request):
        try:
            data = request.data
            cart_id = data['cartid']
            address = data['address']
            email = data['email']
            phone = data['phone']
            cart_obj = Cart.objects.get(id=cart_id)
            cart_obj.isComplit = True
            cart_obj.save()
            Order.objects.create(
                cart=cart_obj,
                email=email,
                address=address,
                phone=phone,
            )
            response_msg = {"error": False, "message": "Your Order is Complit"}
        except:
            response_msg = {"error": True, "message": "Somthing is Wrong !"}
        return Response(response_msg)