class GetFavouriteDataModel {
  bool? status;
  DataModel? data;

  GetFavouriteDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  int? current_page;
  List<DataItem> data = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataItem.fromjson(element));
    });
  }
}

class DataItem {
  var id;
  dataProductItem? product;

  DataItem.fromjson(Map<String, dynamic> json) {
    id=json['id'];
    product=dataProductItem.fromJson(json['product']);
  }
}

class dataProductItem {
  int? id;
  var price;
  var old_price;
  String? image;
  int? discount;
  String? name;
  dataProductItem.fromJson(Map<String, dynamic> json){
    id=json['id'];
    price=json['price'];
    old_price=json["old_price"];
    discount=json["discount"];
    image=json['image'];
    name=json['name'];

  }
}
