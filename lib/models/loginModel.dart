class LoginModel {
  bool status;
  String? massege;
  UserData? data;

  LoginModel({required this.data, required this.status, required this.massege});

  factory LoginModel.fromjson(dynamic data) {
    return LoginModel(
        data: data['data'] != null ? UserData.fromJson(data['data']) : null,
        status: data['status'],
        massege: data['message']);
  }
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String token;

  UserData(
      {required this.email,
      required this.name,
      required this.id,
      required this.phone,
      required this.token});

  factory UserData.fromJson(dynamic data) {
    return UserData(
        email: data['email'],
        name: data['name'],
        id: data['id'],
        phone: data['phone'],
        token: data['token']);
  }
}
