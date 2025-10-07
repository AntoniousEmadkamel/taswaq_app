import 'package:dio/dio.dart';
class DioHelper {
  static late Dio dio;

  static void init() {
  dio = Dio(
    BaseOptions(
        baseUrl: "https://accept.paymob.com/api",
        connectTimeout: Duration(seconds: 30),
        receiveTimeout: Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        },
        receiveDataWhenStatusError: true),
  );
  // Add interceptor for debugging
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
  }


  static Future<Response> postData(
      {required String url, Map<String, dynamic>? data}) async {
    return await dio.post(url, data: data);
  }
}