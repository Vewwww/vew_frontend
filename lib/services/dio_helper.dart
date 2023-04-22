import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        //TODO::add base url
        baseUrl:"", 
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token
  }) async {
    /*dio.options.headers = {
      "Content-Type": "application/json",
    };*/
    if(token != null) dio.options.headers["Authorization"] = "Bearer $token";
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token
  }) async {
    /*dio.options.headers = {
      "Content-Type": "application/json",
    };*/
    if(token != null) dio.options.headers["Authorization"] = "Bearer $token";
    return await dio
        .post(
      url,
      queryParameters: query,
      data: data,
    )
        .catchError((e) {
      print(e);
    });
  }
  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token
  }) async {

    if(token != null) dio.options.headers["Authorization"] = "Bearer $token";
    return await dio
        .patch(
      url,
      queryParameters: query,
      data: data,
    )
        .catchError((e) {
      print(e);
    });
  }
}