import 'package:flutter/material.dart';
import 'package:shop_app/screens/cat3.dart';
import 'package:shop_app/screens/favorit_screens.dart';
import 'package:shop_app/screens/home_Screens.dart';
import 'package:shop_app/screens/login_screens.dart';
import 'package:shop_app/screens/order_history_screens.dart';
import 'package:localstorage/localstorage.dart';

import '../screens/cat2.dart';

class AppDrower extends StatefulWidget {
  @override
  _AppDrowerState createState() => _AppDrowerState();
}

class _AppDrowerState extends State<AppDrower> {
  LocalStorage storage = new LocalStorage('usertoken');

  void _logoutnew() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScrrens.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.black,
            title: Text("Welcome"),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Home_Screens.routeName);
            },
            trailing: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: Text("Home"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FalvoritScreens.routeName);
            },
            trailing: Icon(
              Icons.add_box_rounded,
              color: Colors.red,
            ),
            title: Text("cat1"),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FalvoritScreens2.routeName);
            },
            trailing: Icon(
              Icons.add_box_rounded,
              color: Colors.red,
            ),
            title: Text("cat2"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FalvoritScreens3.routeName);
            },
            trailing: Icon(
              Icons.add_box_rounded,
              color: Colors.red,
            ),
            title: Text("cat3"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrderScreens.routeName);
            },
            trailing: Icon(
              Icons.history,
              color: Colors.blue,
            ),
            title: Text("Old Orders"),
          ),
          Spacer(),
          ListTile(
            onTap: () {
              _logoutnew();
            },
            trailing: Icon(
              Icons.logout,
              color: Colors.green,
            ),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
