import 'package:networking_practice/config/environment/environment.dart';

class ApiEndpoints {
  //static const String KEY = "0e55bfbe7800416090265134241609";
  //static const String BASE_URL = "http://api.weatherapi.com/v1";

  static String CURRENT_WEATHER({required String q}) =>
      "/current.json?key=${Environment.key}&q=${q}";
}
