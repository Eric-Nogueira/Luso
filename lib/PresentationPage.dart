import 'dart:async';
import 'package:flutter/material.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {

  @override
  void initState() {
    super.initState();
    // Schedule the navigation after a delay
    Future.delayed(const Duration(seconds: 3), () {
      // Use Navigator.pushReplacement to navigate to the new page
      // and prevent going back to the splash screen
      Navigator.pushReplacementNamed(
        context,
        '/home',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
        body: Stack(
          children: [
            Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 0, 87, 180),
                Color.fromARGB(255, 17, 0, 116),
              ],
            ),
          ),
        ),
        Center(
          child: Text(
            'Luso App',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ]),
    );
  }
}

