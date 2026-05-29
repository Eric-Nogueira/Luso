import 'package:flutter/material.dart';
import 'PresentationPage.dart';
import 'package:luso/HomePage.dart';

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
        '/': (context) => const PresentationPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}