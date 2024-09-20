import 'package:networking_practice/feature/weather/models/weather_data_model.dart';

class WeatherGeneric {
  bool showCollapsedView;
  bool isLoading;
  bool isSearchEnabled;
  WeatherData? currentWeatherData;

  WeatherGeneric({
    this.showCollapsedView = false,
    this.isLoading = false,
    this.currentWeatherData,
    this.isSearchEnabled = false,
  });

  WeatherGeneric update({
    bool? showCollapsedView,
    bool? isLoading,
    WeatherData? currentWeatherData,
    bool? isSearchEnabled,
  }) {
    return WeatherGeneric(
      showCollapsedView: showCollapsedView ?? this.showCollapsedView,
      isLoading: isLoading ?? this.isLoading,
      currentWeatherData: currentWeatherData ?? this.currentWeatherData,
      isSearchEnabled: isSearchEnabled ?? this.isSearchEnabled,
    );
  }
}
