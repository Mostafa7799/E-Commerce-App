import 'package:ecommerce_app/model/product.dart';


List<ProductModel> getProductByCategory(String kJackets, List<ProductModel> allproducts) {
  List<ProductModel> products = [];
  try {
    for (var product in allproducts) {
      if (product.productCategories == kJackets) {
        products.add(product);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return products;
}