import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hourify/app/home_activity.dart';
import 'package:hourify/features/home/home_screen.dart';
import 'package:hourify/features/splash/splash_screen.dart';

class Hourify extends StatelessWidget {
  const Hourify({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
        )
      ),
      home: AnimatedSplashScreen(
          splash: Image.asset('assets/app_logo.png'),
          duration: 1000,
          nextScreen: HomeActivity()
      ),
    );
  }
}
