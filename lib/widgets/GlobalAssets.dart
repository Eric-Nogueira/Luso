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
                Color.fromARGB(255, 250, 250, 250),
                Color.fromARGB(255, 220, 220, 220),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget elbutton(String text, VoidCallback onPressed, Color bgColor, int width) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: bgColor.withAlpha(150),
            blurRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      width: width.isNaN ? 300 : width.toDouble()+10,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: SizedBox(
          width: width.isNaN ? 300 : width.toDouble()+10,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
