import 'package:sembast/sembast.dart';

import '../../../config/di/dependency_injection.dart';
import '../sembest/sembest_db_config.dart';

class CityDao {
  final _weatherStore = stringMapStoreFactory.store("weather_app");
  SembestDbConfig sembestDbConfig = sl.get<SembestDbConfig>();
  static const String CITY_KEY = "cities";

  Future<List<String>> readCities() async {
    List<String> cityList = [];
    try {
      var result = await _weatherStore.record(CITY_KEY).get(sembestDbConfig.db);
      //cityList = result.map((e) => TodoTable.fromJson(e.value)).toList();
      for (var item in result![CITY_KEY] as List) {
        cityList.add(item);
      }
    } catch (e) {
      print("Error in city DAO readCities()");
      print(e.toString());
    }
    print("in city DAO");
    print(cityList);
    return cityList;
  }

  Future<void> insertCities(Map<String, List<String>> cities) async {
    try {
      await _weatherStore.record(CITY_KEY).put(sembestDbConfig.db, cities);
    } catch (e) {
      print(e.toString());
    }
  }
}
