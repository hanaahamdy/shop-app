class HomeModel {
  bool? status;
  HomeData? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData {
  List<ProductModel> products = [];
  List<BannersModel> banners = [];

  HomeData.fromJson(Map<String, dynamic> json) {
    json["banners"].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannersModel {
  int? id;
  String? image;

  BannersModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    image = data['image'];
  }
}

class ProductModel{
  int? id;
var  price;
  var old_price;
  bool? favorites;
  int?discount;
  String?image;
  String?name;
  String?description;
  bool?in_cart;
ProductModel.fromJson (Map<String,dynamic>json)
{
  in_cart=json['in_cart'];
  id=json["id"];
  favorites=json['in_favorites'];
price=json["price"];
  image=json["image"];
old_price=json["old_price"];
discount=json['discount'];
name=json["name"];
description=json['description'];


  }



}
