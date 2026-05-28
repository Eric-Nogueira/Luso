import 'package:flutter/material.dart';

class Assets {
  Widget appBar(BuildContext context, String route, Icon icon, String tooltip) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: icon,
        tooltip: tooltip,
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }

  Widget background() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 231, 231, 231),
                Color.fromARGB(255, 200, 200, 200),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
