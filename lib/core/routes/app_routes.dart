import 'dart:io';

import 'package:flutter/material.dart';

import '../../features/splash/splash_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

class Routes {
  static const String initialRoute = "/";
  static const String home = "/home";
}

class AppRoutes {
  static Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //!Splash Screen
      case (Routes.initialRoute):
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case (Routes.home):
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => SafeArea(
            top: false,
            bottom: Platform.isAndroid,
            child: const Scaffold(body: Center(child: Text('No Found Route'))),
          ),
        );
    }
  }
}
