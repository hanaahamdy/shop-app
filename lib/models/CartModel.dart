class CartModel
{bool? status;
DataModel? data;
CartModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  data=DataModel.fromJson(json['data']);

}

}
class DataModel{
List<CartItem>cart_items=[];
var sub_total;
var total;
DataModel.fromJson(Map<String,dynamic>json){
  sub_total=json['sub_total'];
  total=json['total'];
  json["cart_items"].forEach((element){cart_items.add(CartItem.fromJson(element));});


}
}
class CartItem{
  int? quantity;
  int? id;
  ProductData?product;
  CartItem.fromJson(Map<String,dynamic>json)
  {
id=json['id'];
quantity=json['quantity'];
product=ProductData.fromJson(json["product"]);
  }

}
class ProductData{
  int? id;
  var price;
  var old_price;
  int?discount;
  String?image;
  String?name;
  bool?in_favorites;
 bool? in_cart;
  ProductData.fromJson(Map<String,dynamic>json)
  {id=json['id'];
  price=json['price'];
  old_price=json['old_price'];
  discount=json['discount'];
  image=json['image'];
  name=json['name'];
  in_favorites=json["in_favorites"];
  in_cart=json['in_cart'];


  }
}