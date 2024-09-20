import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/config/network/api_manager_dio.dart';
import 'package:networking_practice/config/network/http/dio_client.dart';
import 'package:networking_practice/feature/weather/controllers/weather_generic.dart';
import 'package:networking_practice/feature/weather/models/weather_data_model.dart';
import 'package:networking_practice/feature/weather/repository/weather_repository.dart';

final weatherProvider =
    StateNotifierProvider<WeatherController, WeatherGeneric>(
        (ref) => WeatherController(ref: ref));

class WeatherController extends StateNotifier<WeatherGeneric> {
  WeatherController({required this.ref}) : super(WeatherGeneric());

  ApiManagerDio apiManager = ApiManagerDio();
  WeatherRepository weatherRepository = WeatherRepository(DioClient().dio);

  //ApiManagerHTTP apiManager = ApiManagerHTTP();

  Ref ref;

  toggleAppbar(bool isCollapsed) {
    state = state.update(showCollapsedView: isCollapsed);
  }

  toggleSearchButton(bool isSearchEnabled) {
    print(isSearchEnabled.toString());
    state = state.update(isSearchEnabled: isSearchEnabled);
  }

  fetchCurrentWeather({required String currentLocation}) async {
    WeatherData? weatherData;
    BotToast.showLoading();
    state = state.update(isLoading: true);

    Object result =
        await weatherRepository.getCurrentWeather(location: currentLocation);

    BotToast.closeAllLoading();

    if (result is WeatherData) {
      weatherData = result;
    } else {
      BotToast.showText(text: "Something went wrong");
    }

    state = state.update(isLoading: false, currentWeatherData: weatherData);
  }
}

