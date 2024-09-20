import 'package:networking_practice/feature/country/models/country_data_model.dart';

class CountryGeneric {
  List<CountryData>? countryData;
  List<String>? cityList;
  bool isLoading;

  CountryGeneric({this.countryData, this.isLoading = false, this.cityList});

  CountryGeneric update(
      {List<CountryData>? countryData,
      bool? isLoading,
      List<String>? cityList}) {
    return CountryGeneric(
        countryData: countryData ?? this.countryData,
        isLoading: isLoading ?? this.isLoading,
        cityList: cityList ?? this.cityList);
  }
}
