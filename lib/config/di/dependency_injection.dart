import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:networking_practice/database/local/daos/city_dao.dart';

import '../../database/local/sembest/sembest_db_config.dart';

final sl = GetIt.I;

Future<void> setupService() async {
  await dotenv.load(fileName: ".env");
  sl.registerSingletonAsync<SembestDbConfig>(() async {
    log("sembast init");
    final sembastdbConfig = SembestDbConfig();
    await sembastdbConfig.init();
    return sembastdbConfig;
  });

  // sl.registerSingletonAsync<CityDao>(() async {
  //   log("cityDao init");
  //   final dao = CityDao();
  //   return dao;
  // }, dependsOn: [SembestDbConfig]);

  sl.registerLazySingleton(() => CityDao());
  await sl.allReady();
}
