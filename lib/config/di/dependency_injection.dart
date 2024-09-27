import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:networking_practice/config/notification/push_notification/push_notification_handler.dart';
import 'package:networking_practice/database/local/daos/city_dao.dart';
import 'package:networking_practice/database/local/shared_preferences/shared_preferences_config.dart';

import '../../database/local/sembest/sembest_db_config.dart';
import '../../firebase_options.dart';
import '../notification/local_notification/local_notification_handler.dart';

final sl = GetIt.I;

Future<void> setupService() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalNotificationHandler();
  PushNotificationHandler();

  await dotenv.load(fileName: ".env");
  sl.registerSingletonAsync<SembestDbConfig>(() async {
    log("sembast init");
    final sembastdbConfig = SembestDbConfig();
    await sembastdbConfig.init();
    return sembastdbConfig;
  });

  sl.registerSingletonAsync<CityDao>(() async {
    log("cityDao init");
    final dao = CityDao();
    return dao;
  }, dependsOn: [SembestDbConfig]);

  sl.registerSingletonAsync<SharedPreferencesConfig>(() async {
    SharedPreferencesConfig prefs = SharedPreferencesConfig();
    await prefs.init();
    return prefs;
  });

  //sl.registerLazySingleton(() => CityDao());
  await sl.allReady();
}
