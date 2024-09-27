import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:networking_practice/database/local/shared_preferences/shared_preferences_config.dart';

import '../../../config/app_themes.dart';
import '../../../config/di/dependency_injection.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferencesConfig prefs = sl.get<SharedPreferencesConfig>();

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    Timer(Duration(seconds: 1), () {
      moveToNextScreen();
    });
  }

  moveToNextScreen() async {
    bool isLoggedIn = await prefs.checkLoginStatus();
    if (isLoggedIn) {
      GoRouter.of(context).goNamed("weather");
    } else {
      GoRouter.of(context).goNamed("login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.ac_unit_outlined,
          color: AppThemes.lightColorScheme.primary,
          size: 150,
        ),
      ),
    );
  }
}
