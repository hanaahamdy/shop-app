import 'package:dio/dio.dart';

import '../screens/const.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getData({required String url, String? token,String lang="en"}) async {
    dio.options.headers = {
      "Authorization": token ?? '',
      "lang":lang,
      "Content-Type": "application/json"
    };
    return await dio.get(url);
  }

  static Future<Response> postData(
      {required String url, Map<String, dynamic>? data, String? token,String lang="en"}) async {
    dio.options.headers = {
      "Authorization": token ?? '',
      "Content-Type": "application/json",
     "lang":lang,
    };
    return await dio.post(url, data: data);
  }
}
