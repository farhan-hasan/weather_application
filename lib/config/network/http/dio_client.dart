import 'package:dio/dio.dart';
import 'package:networking_practice/config/environment/environment.dart';
import 'package:networking_practice/config/network/http/interceptors/error_interceptor.dart';
import 'package:networking_practice/config/network/http/interceptors/key_interceptor.dart';

class DioClient {
  Map<String, String> commonHeader = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };
  late Dio dio;

  DioClient() {
    dio = Dio()
      ..options.baseUrl = Environment.base_url
      ..options.headers = commonHeader
      ..interceptors.addAll([KeyInterceptor(), ErrorInterceptor()]);
  }
}
