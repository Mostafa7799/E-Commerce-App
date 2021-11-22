
import 'package:ecommerce_app/screens/add_product.dart';
import 'package:ecommerce_app/screens/manage_product.dart';
import 'package:ecommerce_app/screens/view_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AdminHome extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[500],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              child: MaterialButton(
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => AddProduct()), (Route<dynamic> route) => true);
                },
                child:Text(
                  'Add Product'
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              child: MaterialButton(
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => ManageProduct()), (Route<dynamic> route) => true);
                },
                child:Text(
                  'Edit Product'
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              child: MaterialButton(
                onPressed: (){
                  Navigator.pushNamed(context, ViewProduct.id);
                },
                child:Text(
                  'View Order'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
