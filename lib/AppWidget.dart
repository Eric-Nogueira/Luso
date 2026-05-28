import 'package:flutter/material.dart';
import 'PresentationPage.dart';
import 'package:luso/HomePage.dart';

class Appwidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light, iconTheme: IconThemeData(color: Colors.white,)),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => PresentationPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}