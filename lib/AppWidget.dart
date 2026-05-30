import 'package:flutter/material.dart';
import 'PresentationPage.dart';
import 'package:luso/HomePage.dart';
import 'package:luso/SplashScreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/presentation': (context) => const PresentationPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}