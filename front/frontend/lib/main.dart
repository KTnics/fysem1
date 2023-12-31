import 'package:flutter/material.dart';
import 'package:shop_app/screens/All.dart';
import 'package:shop_app/screens/cart_screens.dart';
import 'package:shop_app/screens/cat2.dart';
import 'package:shop_app/screens/cat3.dart';
import 'package:shop_app/screens/favorit_screens.dart';
import 'package:shop_app/screens/home_Screens.dart';
import 'package:shop_app/screens/login_screens.dart';
import 'package:shop_app/screens/order_history_screens.dart';
import 'package:shop_app/screens/order_screens.dart';
import 'package:shop_app/screens/product_details_screens.dart';
import 'package:shop_app/screens/register_screens.dart';
import 'package:shop_app/screens/home_Screens.dart';
import 'package:shop_app/state/cart_state.dart';
import 'package:shop_app/state/product_state.dart';
import 'package:shop_app/state/user_state.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalStorage storage = new LocalStorage('usertoken');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductState()),
        ChangeNotifierProvider(create: (ctx) => UserState()),
        ChangeNotifierProvider(create: (ctx) => CartState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (storage.getItem('token') == null) {
              return LoginScrrens();
            }
            return Home_Screens();
          },
        ),
        routes: {
          Home_Screens.routeName: (ctx) => Home_Screens(),
          ProductDetailsScreens.routeName: (ctx) => ProductDetailsScreens(),
          FalvoritScreens.routeName: (ctx) => FalvoritScreens(),
          FalvoritScreens2.routeName: (ctx) => FalvoritScreens2(),
          FalvoritScreens3.routeName: (ctx) => FalvoritScreens3(),
          LoginScrrens.routeName: (ctx) => LoginScrrens(),
          RegisterScreens.routeName: (ctx) => RegisterScreens(),
          CartScreens.routeName: (ctx) => CartScreens(),
          OrderScreens.routeName: (ctx) => OrderScreens(),
          OrderNew.routeName: (ctx) => OrderNew(),
          All.routeName:(ctx)=>All(),
        },
      ),
    );
  }
}
