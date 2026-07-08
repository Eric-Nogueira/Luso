import 'package:flutter/material.dart';
import 'package:luso/widgets/GlobalAssets.dart';

class OfflinePage extends StatefulWidget {
  const OfflinePage({super.key});

  @override
  State<OfflinePage> createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  final Assets assets = Assets();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Background(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/mascotevars/mascote_initial.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sem conexão com a internet',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Inter',
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
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