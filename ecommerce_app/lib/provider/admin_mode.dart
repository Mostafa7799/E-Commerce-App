
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:flutter/cupertino.dart';

class AdminMode extends ChangeNotifier{
  bool isAdmin =false ;

  changeAdmin(bool value){
    isAdmin = value;
    notifyListeners();
  }

  ProductModel model = ProductModel();
  void getProductData(){

    FirebaseFirestore.instance.collection('users').doc(model.productName)
        .get()
        .then((value) {
      var product = ProductModel.fromJson(value.data());
    })
        .catchError((error){

    });
  }
}