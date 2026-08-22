import 'package:flutter/material.dart';
import 'package:luso/widgets/GlobalAssets.dart';

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
            child: PageContent()
          ),
        ],
      ),
    );
  }
}


class PageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 9, 74),
        toolbarHeight: 130,
        title: Image.asset(
          'assets/img/logo/LOGO_LUSO_LIGHT.png',
          fit: BoxFit.fitWidth,
          width: 120,
          alignment: AlignmentGeometry.center,
        ),
      ),
    );
  }
}