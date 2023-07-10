import 'package:flutter/material.dart';
import 'package:shop_app/state/product_state.dart';
import 'package:shop_app/widgets/add_drower.dart';
import 'package:shop_app/widgets/singleProduct.dart';
import 'package:provider/provider.dart';

class FalvoritScreens extends StatelessWidget {
  static const routeName = '/favorit-screens';
  @override
  Widget build(BuildContext context) {
    final favorit = Provider.of<ProductState>(context).cat1;
    return


      Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("bsc"),
        ),
        drawer: AppDrower(),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 2,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),

          itemCount: favorit.length,
          itemBuilder: (ctx, i) => SingleProduct(
            id: favorit[i].id,
            title: favorit[i].title,
            image: favorit[i].image,
            cat1: favorit[i].cat1,
            cat2: favorit[i].cat2,
            cat3: favorit[i].cat3,
          ),
        ),
      );
  }
}
