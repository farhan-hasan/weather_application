import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // BotToast.showText(text: err.message.toString());
    // BotToast.closeAllLoading();
    print(err.message.toString());
    super.onError(err, handler);
  }
}
