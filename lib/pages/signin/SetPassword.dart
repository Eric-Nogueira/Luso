import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:luso/widgets/GlobalAssets.dart';
import 'package:http/http.dart' as http;

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({super.key});

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {

  static const _passwordHint = 'Senha';
  static const _confirmPasswordHint = 'Confirme sua senha';
  static var _speechText = 'Escolha uma senha legal e segura!';
  static const _backIconColor = Color.fromARGB(255, 0, 3, 95);
  static const _containerColor = Color.fromARGB(255, 6, 10, 110);
  var __resposta = 'Resposta da API';
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
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(__resposta, style: const TextStyle(color: Color.fromARGB(255, 255, 0, 0))),
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
                    getData(); // Lógica de login aqui
                  },
                  const Color.fromARGB(255, 0, 5, 145),
                  400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getData() async {
    String url = 'http://localhost:3000';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        __resposta = response.body;
      });
    } else {
      setState(() {
        __resposta = 'Erro ao obter dados';
      });
    }
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
          width: 260,
          height: 55,
          decoration: BoxDecoration(
            color: _SetPasswordPageState._containerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, left: 10.0),
            child: Text(_SetPasswordPageState._speechText, style: _SetPasswordPageState._speechStyle),
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
        _PasswordTextField(),
        SizedBox(height: 16),
        _ConfirmPasswordTextField(),
      ],
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
          hintText: _SetPasswordPageState._passwordHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
    ]);
  }
}
class _ConfirmPasswordTextField extends StatelessWidget {
  const _ConfirmPasswordTextField();

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
          hintText: _SetPasswordPageState._confirmPasswordHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
    ]);
  }
}
