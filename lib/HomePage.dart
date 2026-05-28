import 'package:flutter/material.dart';
import 'package:luso/assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Assets assets = Assets();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          assets.background(),
          Center(
            child: Text(
              'Luso App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
