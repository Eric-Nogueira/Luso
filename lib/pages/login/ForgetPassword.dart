import 'package:flutter/material.dart';
import 'package:luso/widgets/GlobalAssets.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets().background(),
        Text(
          'Esqueci minha senha',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 4, 0, 76),
            decoration: TextDecoration.none,
          ),
        ),
      ]
    );
  }
}
