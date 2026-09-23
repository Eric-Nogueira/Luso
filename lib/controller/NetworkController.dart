import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      _updateConnectionStatus(results);
    });

    // Veja o Problema 3 abaixo — checar estado inicial.
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    final results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // Se a lista contém apenas "none" (ou está vazia), está offline.
    final isOffline =
        results.isEmpty || results.every((r) => r == ConnectivityResult.none);

    if (isOffline) {
      Get.rawSnackbar(
        messageText: const Text(
          'Sem conexão com a internet',
          style: TextStyle(color: Colors.white),
        ),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: const Color.fromARGB(255, 180, 0, 0),
        icon: const Icon(Icons.wifi_off, color: Colors.white),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
