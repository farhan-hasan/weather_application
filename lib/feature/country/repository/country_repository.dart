import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../models/country_data_model.dart';

part 'country_repository.g.dart';

@RestApi(baseUrl: "https://restcountries.com/")
abstract class CountryRepository {
  factory CountryRepository(Dio di) = _CountryRepository;

  @GET("v3.1/all")
  Future<List<CountryData>> getCountries();
}
