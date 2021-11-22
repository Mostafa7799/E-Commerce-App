
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/componanet/custom_menu.dart';
import 'package:ecommerce_app/const.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/network/store_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_product.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct({Key? key}) : super(key: key);

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {

  var store = StoreData();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
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
            return GridView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
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
                      onTapUp: (details){
                        var dx = details.globalPosition.dx;
                        var dy = details.globalPosition.dy;
                        var dx2 = MediaQuery.of(context).size.width - dx;
                        var dy2 = MediaQuery.of(context).size.width - dy;
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            items: [
                              MyPopupMenuItem(
                                  onClick: (){
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => EditProduct()), (Route<dynamic> route) => true);
                                  },
                                  child: Text('Edit')
                              ),
                              MyPopupMenuItem(
                                  onClick: (){
                                    store.delete(products[index].productName);
                                    print('ok');
                                  },
                                  child: Text('Delete')
                              ),
                            ]
                        );
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Image(
                                  image: AssetImage('${products[index].productLocation}'),
                                fit: BoxFit.fill,
                              ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              margin: EdgeInsets.only(left: 5,bottom: 1),
                              height: MediaQuery.of(context).size.height*.09,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadiusDirectional.circular(10)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7,top: 4),
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            );
          }else{
            return Center(child: CircularProgressIndicator(semanticsLabel: 'Loading...',));
          }
        },
      ),
    );
  }
}
