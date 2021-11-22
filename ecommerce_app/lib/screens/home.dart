import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/componanet/functions.dart';
import 'package:ecommerce_app/const.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/network/store_data.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/product_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index=0;

  int indexNav=0;

  var store = StoreData();

  List<ProductModel> products=[];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                 title: Text('Home Page'),
                 backgroundColor: Colors.white,
                 elevation: 0,
                bottom: TabBar(
                  labelColor: Colors.black54,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: backGroundColor,
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(
                      fontSize: 19
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  onTap: (value){
                    setState(() {
                      value = index;
                    });
                  },
                  tabs: [
                    Text('Jackets'),
                    Text('Trouser'),
                    Text('T-Shirts'),
                    Text('Shoes'),
                  ],
                ),
               ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: indexNav,
                onTap: (value){
                 setState(() {
                   indexNav = value;
                 });
                },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home'
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile'
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.close),
                      label: 'Sign Out'
                    ),
                  ],
              ),
              body: TabBarView(
                  children: [
                    jacketView(),
                    trousersView(),
                    shirtsView(),
                    shoesView(),
                  ],
              ),
            ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height*.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87
                    ),
                  ),
                  IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      icon: Icon(Icons.shopping_cart,color: Colors.black87,)
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: store.getProduct(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          List<ProductModel> products =[];
          for (var docs in snapshot.data.docs) {
            var data = docs.data();
            products.add(ProductModel(
              productName: data['pName'],
              productPrice: data['pPrice'],
              productDescription: data['pDescription'],
              productCategories: data['pCategories'],
              productLocation: data['pLocation'],
            ));
          }
          var _products = [...products];
          products.clear();
          products = getProductByCategory("man\'s",_products);
            return GridView.builder(
               itemBuilder: (BuildContext context, int index) {
                   return Padding(
                   padding: const EdgeInsets.symmetric(
                       vertical: 8.0, horizontal: 8),
                   child: Container(
                     decoration: BoxDecoration(
                       // boxShadow: [
                       //   BoxShadow(
                       //     color: Colors.grey.shade100,
                       //     spreadRadius: 1,
                       //     blurRadius: 7,
                       //     offset: Offset(0, 0), // changes position of shadow
                       //   ),
                       // ],
                     ),
                     child: GestureDetector(
                       onTap: (){
                         Navigator.pushNamed(context, ProductInfo.id, arguments: products[index]);
                       },
                       child: Stack(
                         children: [
                           Positioned.fill(
                             child: Image(
                               image: AssetImage(
                                   '${products[index].productLocation}'),
                               fit: BoxFit.fill,
                             ),
                           ),
                           Positioned(
                             bottom: 0,
                             child: Container(
                               margin: EdgeInsets.only(left: 5, bottom: 1),
                               height: MediaQuery
                                   .of(context)
                                   .size
                                   .height * .07,
                               width: MediaQuery
                                   .of(context)
                                   .size
                                   .width,
                               decoration: BoxDecoration(
                                   color: Colors.black45,
                                   borderRadius: BorderRadiusDirectional
                                       .circular(10)
                               ),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Padding(
                                     padding: const EdgeInsets.only(
                                         left: 7, top: 4),
                                     child: Text(
                                       '${products[index].productName}',
                                       maxLines: 1,
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 15,
                                           fontWeight: FontWeight.bold
                                       ),
                                     ),
                                   ),
                                   Text(
                                     '  ${products[index].productPrice}',
                                     maxLines: 1,
                                     style: TextStyle(
                                         color: Colors.white,
                                         fontSize: 15,
                                         fontWeight: FontWeight.bold
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 );
               },
               itemCount: products.length,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2),
             );
        }else{
          return Center(child: CircularProgressIndicator(semanticsLabel: 'Loading...',));
        }
      },
    );
  }
  Widget shoesView() {
    return StreamBuilder<QuerySnapshot>(
      stream: store.getProduct(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          List<ProductModel> products =[];
          for (var docs in snapshot.data.docs) {
            var data = docs.data();
            products.add(ProductModel(
              productName: data['pName'],
              productPrice: data['pPrice'],
              productDescription: data['pDescription'],
              productCategories: data['pCategories'],
              productLocation: data['pLocation'],
            ));
          }
          var _products = [...products];
          products.clear();
          products = getProductByCategory("shoes",_products);
          return GridView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.shade100,
                    //     spreadRadius: 1,
                    //     blurRadius: 7,
                    //     offset: Offset(0, 0), // changes position of shadow
                    //   ),
                    // ],
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, ProductInfo.id, arguments: products[index]);
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image(
                            image: AssetImage(
                                '${products[index].productLocation}'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            margin: EdgeInsets.only(left: 5, bottom: 1),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .09,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadiusDirectional
                                    .circular(10)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7, top: 4),
                                  child: Text(
                                    '${products[index].productName}',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text(
                                  '  ${products[index].productPrice}',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          );
        }else{
          return Center(child: CircularProgressIndicator(semanticsLabel: 'Loading...',));
        }
      },
    );
  }
  Widget trousersView() {
    return StreamBuilder<QuerySnapshot>(
      stream: store.getProduct(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          List<ProductModel> products =[];
          for (var docs in snapshot.data.docs) {
            var data = docs.data();
            products.add(ProductModel(
              productName: data['pName'],
              productPrice: data['pPrice'],
              productDescription: data['pDescription'],
              productCategories: data['pCategories'],
              productLocation: data['pLocation'],
            ));
          }
          var _products = [...products];
          products.clear();
          products = getProductByCategory("Trousers",_products);
          return GridView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.shade100,
                    //     spreadRadius: 1,
                    //     blurRadius: 7,
                    //     offset: Offset(0, 0), // changes position of shadow
                    //   ),
                    // ],
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, ProductInfo.id, arguments: products[index]);
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image(
                            image: AssetImage(
                                '${products[index].productLocation}'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            margin: EdgeInsets.only(left: 5, bottom: 1),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .09,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadiusDirectional
                                    .circular(10)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7, top: 4),
                                  child: Text(
                                    '${products[index].productName}',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text(
                                  '  ${products[index].productPrice}',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          );
        }else{
          return Center(child: CircularProgressIndicator(semanticsLabel: 'Loading...',));
        }
      },
    );
  }
  Widget shirtsView() {
    return StreamBuilder<QuerySnapshot>(
      stream: store.getProduct(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          List<ProductModel> products =[];
          for (var docs in snapshot.data.docs) {
            var data = docs.data();
            products.add(ProductModel(
              productName: data['pName'],
              productPrice: data['pPrice'],
              productDescription: data['pDescription'],
              productCategories: data['pCategories'],
              productLocation: data['pLocation'],
            ));
          }
          var _products = [...products];
          products.clear();
          products = getProductByCategory("T-Shirt",_products);
          return GridView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.shade100,
                    //     spreadRadius: 1,
                    //     blurRadius: 7,
                    //     offset: Offset(0, 0), // changes position of shadow
                    //   ),
                    // ],
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, ProductInfo.id, arguments: products[index]);
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image(
                            image: AssetImage(
                                '${products[index].productLocation}'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            margin: EdgeInsets.only(left: 5, bottom: 1),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .09,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadiusDirectional
                                    .circular(10)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7, top: 4),
                                  child: Text(
                                    '${products[index].productName}',
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                Text(
                                  '  ${products[index].productPrice}',
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          );
        }else{
          return Center(child: CircularProgressIndicator(semanticsLabel: 'Loading...',));
        }
      },
    );
  }
}
