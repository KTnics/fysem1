import 'package:flutter/material.dart';
import 'package:shop_app/screens/order_history_screens.dart';
//import 'package:shop_app/screens/order_screens.dart';
import 'package:shop_app/screens/cart_screens.dart';
import 'package:shop_app/constant/color_constant.dart';
import 'package:shop_app/state/cart_state.dart';
import 'package:shop_app/state/product_state.dart';
import 'package:shop_app/widgets/add_drower.dart';
import 'package:shop_app/widgets/singleProduct.dart';
import 'package:provider/provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'All.dart';
import 'cat2.dart';
import 'cat3.dart';
import 'favorit_screens.dart';
import 'home_Screens.dart';
import 'login_screens.dart';

class Home_Screens extends StatefulWidget {
  static const routeName = '/Homescreens';
  int _selectedCategory = 0;

  @override
  _Home_ScreensState createState() => _Home_ScreensState();
}

class _Home_ScreensState extends State<Home_Screens> {
  bool _init = true;


  bool _isLoding = false;
  LocalStorage storage = new LocalStorage('usertoken');

  void _logoutnew() async {
    await storage.clear();
    Navigator.of(context).pushReplacementNamed(LoginScrrens.routeName);
  }

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

  int pageIndex = 0;

  final pages = [
    Home_Screens(),
    CartScreens(),
    FalvoritScreens(),
    OrderScreens(),
  ];
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    final product = Provider
        .of<ProductState>(context)
        .poducts;
    if (!_isLoding)
      return Scaffold(
        appBar: AppBar(
          title: Text("Welcome "),
        ),
        body: Center(
          child: Text("Somthing is Wrong Try Agane!"),
        ),
      );
    else
      return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(

          height: 60,
          decoration: BoxDecoration(

            color: Colors.blue,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),

          ),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Home_Screens.routeName);
                },
                icon: const Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(OrderScreens.routeName);
                },
                icon: const Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(CartScreens.routeName);
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  _logoutnew();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        ),


        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Welcome"),
          centerTitle: true,
          actions: [



            IconButton(
              onPressed: () {
                _logoutnew();
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        //drawer: AppDrower(),


        body:








        DefaultTabController(
          length: 0,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 300.0,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  flexibleSpace: Stack(
                    children: <Widget>[

                      Container(

                        child:


                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: size.height * .40,
                                width: size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage("images/imbook.jpg"),
                                      fit: BoxFit.cover),
                                    color: ColorConstant.appColor,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(
                                        40.0,
                                      ),
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: size.height * .05,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.width * .04),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          // Image.asset(
                                          //   'assets/images/menu.png',
                                          //   width: size.width * .1,
                                          // ),
                                          SvgPicture.asset(
                                            'assets/images/menu.svg',
                                            semanticsLabel: 'Acme Logo',
                                            width: size.width * .1,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white30,
                                                borderRadius: BorderRadius.circular(
                                                  10.0,
                                                )),
                                            child: Icon(
                                              Icons.search_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * .02,
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: size.width * .04,
                                        ),
                                        child: Text(
                                          'What do\nyou want to Read ?',
                                          style: TextStyle(
                                            fontSize: size.width * .08,
                                            color: Colors.black,
                                          ),
                                        )),
                                    SizedBox(
                                      height: size.height * .02,
                                    ),
                                   Container(
                                     child: Row(

                                       children: <Widget>[
                                         Expanded(child: ElevatedButton(onPressed: (








                                             ) {

                                             Navigator.of(context)
                  .pushReplacementNamed(FalvoritScreens.routeName);


                                         },child: Text("Popular"),style: ElevatedButton.styleFrom(
                                             primary: Colors.blue,
                                             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(20),
                                             ),
                                             textStyle: TextStyle(
                                                 fontSize: 30,
                                                 fontWeight: FontWeight.bold)),)),


                                         Expanded(child: ElevatedButton(onPressed: () {  Navigator.of(context)
                                             .pushReplacementNamed(FalvoritScreens3.routeName);},child: Text("UG"),style: ElevatedButton.styleFrom(
                                             primary: Colors.blue,
                                             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(20),
                                             ),
                                             textStyle: TextStyle(
                                                 fontSize: 30,
                                                 fontWeight: FontWeight.bold)),)),


                                         Expanded(child: ElevatedButton(onPressed: () {  Navigator.of(context)
                                             .pushReplacementNamed(FalvoritScreens2.routeName);},child: Text("PG"),style: ElevatedButton.styleFrom(
                                             primary: Colors.blue,
                                             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(20),
                                             ),
                                             textStyle: TextStyle(
                                                 fontSize: 30,
                                                 fontWeight: FontWeight.bold)),)),

                                       ],



                                     ),
                                   ),





                                    SizedBox(
                                      height: size.height * .02,
                                    ),
                                  ],
                                ),
                              ),




                              Container(
                                margin: EdgeInsets.only(
                                  left: size.width * .04,
                                  right: size.width * .04,
                                  top: size.width * .04,
                                ),
                                child: Text(
                                  'New Releases',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * .06,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),










                            ],
                          ),
                        ),







                      ),








                    ],
                  ),
                ),
                SliverPadding(
                  padding: new EdgeInsets.all(0.0),
                  sliver: new SliverList(
                    delegate: new SliverChildListDelegate([

                    ]),
                  ),

                ),
              ];
            },
            body:
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 3,

                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
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









          ),
        ),


        // implement GridView.builder


      );
  }
}

