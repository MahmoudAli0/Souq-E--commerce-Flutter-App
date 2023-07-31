import 'package:dio/dio.dart';

class DioHelper {
  static var dio= Dio();
  static init() {
    dio = Dio(
        BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response> getData({
    required String url,
     Map<String, dynamic>? query,
    String lang='en',
    String? token,
  }) async {
    dio.options.headers={
      'Content-Type': 'application/json',
      'lang':lang,
      'Authorization':token
    };
    return await dio.get(url
    );
  }

  static Future<Response> postData(
      {
    required String url,
     Map<String, double>? query,
    required Map<String, dynamic> data,
    String lang='en',
    String? token,
}) async{
    dio.options.headers={
      'Content-Type': 'application/json',
      'lang':lang,
      'Authorization':token
    };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> putData(
      {
        required String url,
        Map<String, double>? query,
        required Map<String, dynamic> data,
        String lang='en',
        String? token,
      }) async{
    dio.options.headers={
      'Content-Type': 'application/json',
      'lang':lang,
      'Authorization':token
    };
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
