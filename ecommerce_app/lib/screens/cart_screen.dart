
import 'package:ecommerce_app/componanet/custom_menu.dart';
import 'package:ecommerce_app/componanet/widget.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/network/store_data.dart';
import 'package:ecommerce_app/provider/cart_item.dart';
import 'package:ecommerce_app/screens/product_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static final id = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = Provider.of<CartItem>(context).products;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context,index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTapUp: (details){
                            showCustomMenu(context,details,products[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height*.15,
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadiusDirectional.circular(15),
                            ),
                            child:Row(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage('${products[index].productLocation}'),
                                ),
                                SizedBox(width: 5,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${products[index].productName}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(
                                      "${products[index].productPrice}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    '${products[index].count}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25
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
              ),
            ),
            GestureDetector(
              onTap: (){
                getCustomDialog(products,context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: MediaQuery.of(context).size.height*.09,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Text(
                    "Order".toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),
                  ),
                ),
              ),
          ],
        ),
    );
  }

  showCustomMenu(context,details,product)async{
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
                Navigator.pop(context);
                Provider.of<CartItem>(context,listen: false).delete(product);
                Navigator.pushNamed(context, ProductInfo.id,arguments: product);
              },
              child: Text('Edit')
          ),
          MyPopupMenuItem(
              onClick: (){
                Navigator.pop(context);
                Provider.of<CartItem>(context,listen: false).delete(product);
              },
              child: Text('Delete')
          ),
        ]
    );
  }

  getCustomDialog(List<ProductModel> products,context)async{
    var store = StoreData();
    var controller = TextEditingController();
    var price = getTotalPrice(products);
    AlertDialog alertDialog = AlertDialog(
      actions: [
        TextButton(
            onPressed: (){
              try{
                store.storeData({
                  'price': price,
                  'address':controller.text,
                },products);
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    snack(Colors.greenAccent, "Successful"));
                Navigator.pop(context);
              }catch(error){
                print(error.toString());
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                    snack(Colors.red, "Some error"));
              }
            },
            child: Text('Confirm')
        ),
      ],
      content: customField(
        controller: controller,
        hint: 'Enter your address'
      ),
      title: Text('Total Price = \$ $price'),
    );
    await showDialog(
        context: context,
        builder: (context){
          return alertDialog;
        }
    );
  }

  getTotalPrice(List<ProductModel> products) {
    var price =0;
    for(var product in products){
      price += product.count! * int.parse('10');
    }
    return price;
  }
}
