import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/config/app_themes.dart';

import 'config/di/dependency_injection.dart';
import 'feature/weather/view/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupService();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Networking Demo',
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightThemeData,
        home: WeatherScreen(),
      ),
    );
  }
}