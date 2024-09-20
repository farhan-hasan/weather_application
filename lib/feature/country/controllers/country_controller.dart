import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/config/network/http/dio_client.dart';
import 'package:networking_practice/database/local/daos/city_dao.dart';
import 'package:networking_practice/feature/country/controllers/mixin/country_mixin.dart';
import 'package:networking_practice/feature/country/models/country_data_model.dart';
import 'package:networking_practice/feature/country/repository/country_repository.dart';

import '../../../config/di/dependency_injection.dart';
import 'country_generic.dart';

final countryProvider =
    StateNotifierProvider<CountryController, CountryGeneric>(
        (ref) => CountryController());

class CountryController extends StateNotifier<CountryGeneric>
    with CountryMixin {
  CountryController() : super(CountryGeneric());

  CityDao cityDao = sl.get<CityDao>();
  CountryRepository countryRepository = CountryRepository(DioClient().dio);

  fetchCities() async {
    state = state.update(isLoading: true);
    List<CountryData>? countryList = await fetchCountries(countryRepository);
    List<String> cityList = [];
    for (CountryData country in countryList ?? []) {
      for (String capital in country.capital ?? []) {
        cityList.add("$capital, ${country.name?.common}");
      }
    }
    print(cityList);
    state.cityList = cityList;
    state = state.update(isLoading: false);
    storeCitiesToLocalDatabase(cityList);
    return cityList;
  }

  Future<List<String>> readCitiesFromLocalDatabase() async {
    List<String> localDatabaseCityList = await cityDao.readCities();
    return localDatabaseCityList;
  }

  storeCitiesToLocalDatabase(List<String> cityList) {
    cityDao.insertCities({CityDao.CITY_KEY: cityList});
  }
}
