import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Schedule the navigation after a delay
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      // Use Navigator.pushReplacement to navigate to the new page
      // and prevent going back to the splash screen
      Navigator.pushReplacementNamed(context, '/presentation');
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
              'assets/img/logo/LOGO_LUSO_LIGHT.png',
              fit: BoxFit.fitWidth,
              width: 220,
            ),
            Text(
              'Gabaritando o Enem sem complicação',
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Inter',
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
