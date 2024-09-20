import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    BotToast.showText(text: err.message.toString());
    BotToast.closeAllLoading();
    super.onError(err, handler);
  }
}
