

import 'dart:async';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:flutter/cupertino.dart';


class StoreData{
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  addProduct(ProductModel model){
    FirebaseFirestore.instance.collection(product).doc(model.productName).set({
      'pName': model.productName,
      'pDescription': model.productDescription,
      'pLocation': model.productLocation,
      'pCategories': model.productCategories,
      'pPrice': model.productPrice
    }).then((value) {
      print('success');
    }).catchError((e){
      print(e.toString());
    });
  }

  Stream<QuerySnapshot> getProduct(){
     return fireStore.collection('product').snapshots();
  }

  delete(docId){
    fireStore.collection('product').doc(docId).delete();
  }

  edit({
    required String name,
    required String price
}){
    ProductModel model = ProductModel(
      productName: name,
      productPrice: price,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.productName)
        .update(model.toMap()).then((value) {
          getProduct();
    }).catchError((error){
      print('Error');
    });
  }


  storeData(data,List<ProductModel> products){
    var docRef = fireStore.collection('orders').doc();
    docRef.set(data);
    for(var product in products){
      docRef.collection('orderDetails').doc().set(
        {
          'pName': product.productName,
          'pPrice': product.productPrice,
          'count': product.count,
          'pLocation': product.productLocation
        }
      );
    }
  }

  Stream<QuerySnapshot> loadOrder(){
    return fireStore.collection('orders').snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(docId){
    return fireStore.collection('orders').doc('DhKqg4QllM6TEPyJBtyV').collection('orderDetails').snapshots();
  }

}