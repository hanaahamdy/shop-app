//class CategoryModel {
//  final bool status;
//  DataModel data;
//
//  CategoryModel({required this.data, required this.status});
//
//  factory CategoryModel.fromjson(dynamic jsonData) {
//    return CategoryModel(
//        status: jsonData["status"], data: DataModel.fromJson(jsonData['data']));
//  }
//}
//
//class DataModel {
//  final int current_page;
//  List dataTwo ;
//
//  DataModel({required this.current_page, required this.dataTwo});
//
//  factory DataModel.fromJson(dynamic json) {
//    final List<DataItemModel> filldata = [];
//
//    return DataModel(
//        current_page: json['current_page'],
//        dataTwo: json["data"].forEach((element) {
//          filldata.add(DataItemModel.fromJson(element));
//        }));
//  }
//}
//
//class DataItemModel {
//  final int id;
//  final String image;
//  final String name;
//
//  DataItemModel({required this.image, required this.name, required this.id});
//
//  factory DataItemModel.fromJson(dynamic json) {
//    return DataItemModel(
//        image: json['image'], id: json['id'], name: json['name']);
//  }
//}
class CategoryModel {
  bool? status;
  DataModel? data;

  CategoryModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    data = DataModel.fromJson(jsonData['data']);
  }
}

class DataModel {
  int? current_page;
  List<DataModelItem> item=[];

  DataModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      item.add(DataModelItem.fromJson(element));
    });
  }
}

class DataModelItem {
  int? id;
  String? image;
  String?name;
  DataModelItem.fromJson(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'];
    name=json['name'];
  }
}
