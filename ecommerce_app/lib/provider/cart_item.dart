import 'package:ecommerce_app/model/product.dart';
import 'package:flutter/widgets.dart';

class CartItem extends ChangeNotifier{
  List<ProductModel> products = [];
  addToCart(ProductModel productModel){
    products.add(productModel);
    notifyListeners();
  }

  delete(ProductModel product){
    products.remove(product);
    notifyListeners();
  }
}