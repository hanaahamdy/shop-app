import 'package:shared_preferences/shared_preferences.dart';

class LocalHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is bool)
      return await sharedPreferences.setBool(key, value);


    if (value is String)
      return await sharedPreferences.setString(key, value);


    if (value is double)
      return await sharedPreferences.setDouble(key, value);
    return await sharedPreferences.setInt(key, value);

  }

  static  getData({required String key}) async {
    return await sharedPreferences.get(key);
  }
  static Future<bool> removeData(String? token)
  async{
   return await sharedPreferences.remove(token!);

  }
}
