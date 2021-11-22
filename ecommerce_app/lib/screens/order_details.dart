import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const.dart';
import 'package:ecommerce_app/model/order.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/network/store_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderDetails extends StatelessWidget {

  static final id = 'OrderDetails';
  @override
  Widget build(BuildContext context) {
    var docId = ModalRoute.of(context)!.settings.arguments;
    var store = StoreData();
    return Scaffold(
      backgroundColor: Colors.white12,
      body: StreamBuilder<QuerySnapshot>(
        stream: store.loadOrderDetails(docId),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<ProductModel> products = [];
            for(var doc in snapshot.data!.docs){
              dynamic data = doc.data();
              products.add(ProductModel(
                productName: data['pName'],
                count: data['count'],
                productPrice: data['pPrice']
              ));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          height: MediaQuery.of(context).size.height*.2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadiusDirectional.circular(15),
                            // color: Colors.black54,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total Price = \$ ${products[index].productName}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Address in ${products[index].productCategories}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                'Address in ${products[index].count}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: products.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MaterialButton(
                          color: Colors.black54,
                          onPressed: (){

                          },
                          child: Text(
                              'Confirm',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: MaterialButton(
                          color: Colors.black54,
                          onPressed: (){

                          },
                          child: Text(
                              'Delete',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }else{
            return Center(child: Text('Not has orders now'));
          }
        }
      ),
    );
  }
}
