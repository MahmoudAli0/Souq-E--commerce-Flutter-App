import 'package:shared_preferences/shared_preferences.dart';

class Cashe_Helper{
  static SharedPreferences? sharedPreferences;
  static init() async{
    sharedPreferences=await SharedPreferences.getInstance();
  }
  
  dynamic getData({
  required String Key,
}){
    return sharedPreferences!.get(Key);
  }


  static Future<bool> saveData({
  required String Key,
   required dynamic Value,
}) async
  {
    if(Value is String) {
      return await sharedPreferences!.setString(Key!, Value);
    }
    if(Value is int) {
      return await sharedPreferences!.setInt(Key!, Value);
    }
    if(Value is bool) {
      return await sharedPreferences!.setBool(Key!, Value);
    }
    if(Value is double) {
      return await sharedPreferences!.setDouble(Key!, Value);
    }
    else{
      return true;
    }
  }

  static Future<bool> removeData({
    required String Key,
})async
  {
    return await sharedPreferences!.remove(Key);
  }
}