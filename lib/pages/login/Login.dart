import 'package:flutter/material.dart';
import 'package:luso/widgets/GlobalAssets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const _emailHint = 'E-mail';
  static const _passwordHint = 'Senha';
  static const _speechText = 'Me fale seu e-mail e sua senha!';
  static const _backIconColor = Color.fromARGB(255, 0, 3, 95);
  static const _containerColor = Color.fromARGB(255, 6, 10, 110);
  static const _speechStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Inter',
    color: Colors.white,
    decoration: TextDecoration.none,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Para o fundo do Stack aparecer
      body: Stack(
        children: [
          Assets().background(),
          Padding(
            padding: const EdgeInsets.only(top: 64.0, left: 16.0, right: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: _backIconColor,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/presentation');
                    },
                  ),
                ),
                const _SpeechBubbleRow(),
                const SizedBox(height: 32),
                const _LoginForm(),
                const SizedBox(height: 32),
                Assets().elbutton(
                  'Entrar',
                  () {
                    // Lógica de login aqui
                  },
                  const Color.fromARGB(255, 0, 5, 145),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpeechBubbleRow extends StatelessWidget {
  const _SpeechBubbleRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/img/mascotevars/mascote_search.png',
          fit: BoxFit.fitWidth,
          width: 100,
        ),
        Container(
          width: 250,
          height: 55,
          decoration: BoxDecoration(
            color: LoginPage._containerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 16.0),
            child: Text(LoginPage._speechText, style: LoginPage._speechStyle),
          ),
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        _EmailTextField(),
        SizedBox(height: 16),
        _PasswordTextField(),
      ],
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 6, 10, 110),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: LoginPage._emailHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 6, 10, 110),
          borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: LoginPage._passwordHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
    Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/forget_password');
      },
      child: const Text(
        'Esqueci minha senha',
        style: TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 0, 102, 255),
        ),
      ),
    ),
    )
    ]);
  }
}
