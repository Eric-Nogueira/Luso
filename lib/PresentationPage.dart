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
      if (!mounted) return;
      // Use Navigator.pushReplacement to navigate to the new page
      // and prevent going back to the splash screen
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final double larguraTela = MediaQuery.of(context).size.width;
    //final double alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Container com o gradiente (plano de fundo)
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
          // Texto centralizado
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
              'assets/img/LOGO_LUSO.png',
              fit: BoxFit.fitWidth,
              width: 220,
            ),
            Text(
              'Gabaritando o Enem sem complicação',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            )
              ],
            )
          ),
          // Imagem alinhada na parte inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/img/MASCOTE_LUSO.png',
              fit: BoxFit.fitWidth,
              width: larguraTela,
            ),
          ),
        ],
      ),
    );
  }
}
