import 'package:dio/dio.dart';
import 'package:networking_practice/feature/weather/models/weather_data_model.dart';
import 'package:retrofit/retrofit.dart';

part 'weather_repository.g.dart';

@RestApi()
abstract class WeatherRepository {
  factory WeatherRepository(Dio dio, {String? baseUrl}) = _WeatherRepository;

  @GET("current.json")
  Future<WeatherData> getCurrentWeather({@Query("q") required String location});
}
