class ProductModel{
  String? productName;
  String? productPrice;
  String? productDescription;
  String? productLocation;
  String? productCategories;
  int? count;

  ProductModel({
    this.productCategories,
    this.count,
    this.productDescription,
    this.productLocation,
    this.productName,
    this.productPrice
});

  ProductModel.fromJson(Map<String,dynamic>? json){
    productName = json!['productName'];
    productPrice = json['productPrice'];
    productDescription  = json['productDescription'];
    productLocation   = json['productLocation'];
    productCategories   = json['productCategories'];
  }

  Map<String,dynamic> toMap(){
    return {
      'productName':productName,
      'productPrice':productPrice,
      'productDescription':productDescription,
      'productLocation':productLocation,
      'productCategories':productCategories,
    };
  }
}