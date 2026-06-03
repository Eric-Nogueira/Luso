import 'package:flutter/material.dart';
import 'package:luso/widgets/GlobalAssets.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  final Assets assets = Assets();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          assets.background(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/img/mascotevars/mascote_initial.png',
                  fit: BoxFit.fitWidth,
                  width: 100,
                ),
                Image.asset(
                  'assets/img/logo/LOGO_LUSO_DARK.png',
                  fit: BoxFit.fitWidth,
                  width: 150,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Gabaritando o Enem sem complicação',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Inter',
                    color: Color.fromARGB(255, 52, 55, 127),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                spacing: 14,
                mainAxisSize: MainAxisSize.min,
                children: [
                  assets.elbutton('Quero me cadastrar', () {
                    Navigator.pushReplacementNamed(context, '/signin');
                  }, const Color.fromARGB(255, 0, 8, 239), 300),

                  assets.elbutton('Já tenho uma conta', () {
                    Navigator.pushReplacementNamed(context, '/login');
                  }, const Color.fromARGB(255, 4, 10, 183), 300),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
