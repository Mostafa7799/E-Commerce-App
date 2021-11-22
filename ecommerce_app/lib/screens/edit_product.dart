import 'package:ecommerce_app/componanet/widget.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/network/store_data.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  var nameController = TextEditingController();

  var priceController = TextEditingController();

  var descriptionController = TextEditingController();

  var categoriesController = TextEditingController();

  var locationController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  var store = StoreData();

  var model = ProductModel();


  @override
  Widget build(BuildContext context) {
    nameController.text = model.productName!;
    priceController.text = model.productPrice!;

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
                  InkWell(
                    onTap: (){
                      if(formKey.currentState!.validate())
                      {

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
                        'Edit Product',
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
