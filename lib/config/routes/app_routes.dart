import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:networking_practice/feature/authentication/view/login_screen.dart';
import 'package:networking_practice/feature/authentication/view/signup_screen.dart';
import 'package:networking_practice/feature/authentication/view/splash_screen.dart';
import 'package:networking_practice/feature/weather/view/weather_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static final router = GoRouter(
      initialLocation: "/",
      navigatorKey: rootNavigatorKey,
      routes: <RouteBase>[
        GoRoute(
            path: "/weather",
            builder: (context, state) => const WeatherScreen(),
            name: "weather"),
        GoRoute(
            path: "/login",
            builder: (context, state) => const LoginScreen(),
            name: "login"),
        GoRoute(
            path: "/signup",
            builder: (context, state) => const SignupScreen(),
            name: "signup"),
        GoRoute(
            path: "/",
            builder: (context, state) => const SplashScreen(),
            name: "splash"),
      ]);
}
