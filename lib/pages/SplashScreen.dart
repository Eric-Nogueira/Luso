import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  final Connectivity connectivity = Connectivity();
  RxString route = '/presentation'.obs; // torne observável se quiser reatividade

  @override
  void onInit() {
    super.onInit();
    connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // Verifica se a lista contém apenas "none" ou se está vazia
    if (results.contains(ConnectivityResult.none)) {
      route.value = '/offline';
      print('Sem internet → OfflinePage');
    } else {
      route.value = '/presentation';
      print('Com internet → PresentationPage');
    }
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
  super.initState();
  Future.delayed(const Duration(seconds: 3), () async {
    if (!mounted) return;

    // Obtém o status atual da conectividade
    final connectivity = Connectivity();
    final List<ConnectivityResult> results = await connectivity.checkConnectivity();
    final bool isOffline = results.contains(ConnectivityResult.none);

    // Define a rota com base no status atual
    final String route = isOffline ? '/offline' : '/presentation';
    Navigator.pushReplacementNamed(context, route);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Background(),
          Content(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/img/MASCOTE_LUSO.png',
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/img/logo/LOGO_LUSO_LIGHT.png',
                  fit: BoxFit.fitWidth,
                  width: 220,
                ),
                const Text(
                  'Gabaritando o Enem sem complicação',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
  }
}