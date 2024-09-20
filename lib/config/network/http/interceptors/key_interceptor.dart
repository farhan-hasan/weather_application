import 'package:dio/dio.dart';

class KeyInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    String KEY = "0e55bfbe7800416090265134241609";
    options.queryParameters.update("key", (v) => KEY, ifAbsent: () => KEY);
    print(options.queryParameters);
    super.onRequest(options, handler);
  }
}
