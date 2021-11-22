
import 'package:ecommerce_app/componanet/widget.dart';
import 'package:ecommerce_app/model/product.dart';
import 'package:ecommerce_app/provider/cart_item.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key}) : super(key: key);

  static final id  = 'ProductInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {

  int count = 1;

  @override
  Widget build(BuildContext context) {
    ProductModel products = ModalRoute.of(context)!.settings.arguments as ProductModel;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Image(
              fit: BoxFit.fill,
                image: AssetImage('${products.productLocation}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10),
            child: Container(
              height: MediaQuery.of(context).size.height*.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back)
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
          Positioned(
            bottom: 0,
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Builder(
                      builder: (context) =>InkWell(
                        onTap: (){
                            addToCart(products);
                        },
                        child: Container(
                          padding: EdgeInsets.all(28),
                          height: MediaQuery.of(context).size.height*.13,
                          width: MediaQuery.of(context).size.width*.5,
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(.9),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(80),
                            ),
                          ),
                          child: Text(
                            'add to cart'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8,top: 8,right: 15,bottom: 8),
                      height: MediaQuery.of(context).size.height*.13,
                      width: MediaQuery.of(context).size.width*.5,
                      color: Colors.white.withOpacity(.8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${products.productName}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${products.productDescription}",
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${products.productPrice}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      setState(() {
                                        count++;
                                      });
                                    },
                                    child: CircleAvatar(
                                      maxRadius: 13,
                                      backgroundColor: Colors.orange,
                                      child: Icon(Icons.add,color: Colors.white,),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    '${count.toString()}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  InkWell(
                                    onTap: (){
                                      if(count>1)
                                        setState(() {
                                          count--;
                                        });
                                    },
                                    child: CircleAvatar(
                                      maxRadius: 13,
                                      backgroundColor: Colors.orange,
                                      child: Icon(Icons.remove,color: Colors.white,),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }

  addToCart(ProductModel products){
    CartItem cartItem = Provider.of<CartItem>(context,listen: false);
    products.count = count;
    var productInCart = cartItem.products;
    bool exist =false;
    for(var productInCart in productInCart){
      if(productInCart.productName == products.productName){
        exist=true;
      }
    }
    if(exist){
      ScaffoldMessenger.of(context)
          .showSnackBar(
          snack(Colors.greenAccent, "your added this item before"));
    }else{
      cartItem.addToCart(products);
      ScaffoldMessenger.of(context)
          .showSnackBar(
          snack(Colors.greenAccent, "Successful"));
    }
  }
}
