import 'dart:ui';

import 'package:ecommerce_app/componanet/widget.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/network/store_data.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddProduct extends StatelessWidget {

  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  var categoriesController = TextEditingController();
  var locationController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var store = StoreData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[500],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customField(
                    controller: nameController,
                    hint: 'Product Name'
                  ),
                  SizedBox(height: 15,),
                  customField(
                    controller: priceController,
                    hint: 'Product Price'
                  ),
                  SizedBox(height: 15,),
                  customField(
                    controller: descriptionController,
                    hint: 'Product Description'
                  ),
                  SizedBox(height: 15,),
                  customField(
                    controller: categoriesController,
                    hint: 'Product Categories'
                  ),
                  SizedBox(height: 15,),
                  customField(
                    controller: locationController,
                    hint: 'Product Location'
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      if(formKey.currentState!.validate())
                      {
                        formKey.currentState!.save();
                        store.addProduct(ProductModel(
                          productName: nameController.text,
                          productPrice: priceController.text,
                          productLocation: locationController.text,
                          productDescription: descriptionController.text,
                          productCategories: categoriesController.text
                        ));
                        print(nameController.text);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height*.06,
                      width: MediaQuery.of(context).size.width*.4,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadiusDirectional.circular(10),
                      ),
                      child: Text(
                        'Add Product',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
