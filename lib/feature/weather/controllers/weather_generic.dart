import 'package:networking_practice/feature/weather/models/weather_data_model.dart';

class WeatherGeneric {
  bool showCollapsedView;
  bool isLoading;
  bool isSearchEnabled;
  WeatherData? currentWeatherData;
  String selectedTab;

  WeatherGeneric({
    this.showCollapsedView = false,
    this.isLoading = false,
    this.currentWeatherData,
    this.isSearchEnabled = false,
    this.selectedTab = "Today",
  });

  WeatherGeneric update({
    bool? showCollapsedView,
    bool? isLoading,
    WeatherData? currentWeatherData,
    bool? isSearchEnabled,
    String? selectedTab,
  }) {
    return WeatherGeneric(
      showCollapsedView: showCollapsedView ?? this.showCollapsedView,
      isLoading: isLoading ?? this.isLoading,
      currentWeatherData: currentWeatherData ?? this.currentWeatherData,
      isSearchEnabled: isSearchEnabled ?? this.isSearchEnabled,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}
