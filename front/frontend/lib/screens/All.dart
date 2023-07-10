import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart_screens.dart';
//import 'package:shop_app/screens/temp.dart';
import 'package:shop_app/state/cart_state.dart';
import 'package:shop_app/state/product_state.dart';
import 'package:shop_app/widgets/add_drower.dart';
import 'package:shop_app/widgets/singleProduct.dart';
import 'package:provider/provider.dart';

class All extends StatefulWidget {
  static const routeName = '/AllScreen';

  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  bool _init = true;
  bool _isLoding = false;

  @override
  void didChangeDependencies() async {
    if (_init) {
      Provider.of<CartState>(context).getCartDatas();
      Provider.of<CartState>(context).getoldOrders();
      _isLoding = await Provider.of<ProductState>(context).getProducts();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductState>(context).poducts;
    if (!_isLoding)
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Welcome"),
        ),
        body: Center(
          child: Text("Somthing is Wrong Try Agane!"),
        ),
      );
    else
      return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.black,
            title: Text("Welcome "),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreens.routeName);
                },
                icon: Icon(Icons.shopping_cart),
              ),
            ]


        ),
        drawer: AppDrower(),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 2,
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: product.length,
          itemBuilder: (ctx, i) => SingleProduct(
            id: product[i].id,
            title: product[i].title,
            image: product[i].image,
            cat1: product[i].cat1,
            cat2: product[i].cat2,
            cat3: product[i].cat3,
          ),
        ),
      );
  }
}
