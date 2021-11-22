
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/order.dart';
import 'package:ecommerce_app/network/store_data.dart';
import 'package:ecommerce_app/screens/order_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewProduct extends StatelessWidget {

  static final id  = 'viewProduct';
  var store = StoreData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: StreamBuilder<QuerySnapshot>(
        stream: store.loadOrder(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: Text('is Empty'));
          }else{
            List<Order> orders = [];
            for(var doc in snapshot.data!.docs){
              dynamic data = doc.data();
              orders.add(Order(
                address: data['address'],
                totalPrice: data['price'],
                docId: data['docId'],
              ));
            }
            return ListView.builder(
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, OrderDetails.id,arguments: orders[index].docId);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        height: MediaQuery.of(context).size.height*.2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(15),
                          color: Colors.black54,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Total Price = \$ ${orders[index].totalPrice}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Address in ${orders[index].address}',
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
                    ),
                  );
                },
                itemCount: orders.length,
            );
          }
        }
      ),
    );
  }
}
