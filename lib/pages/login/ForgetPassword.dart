import 'package:flutter/material.dart';
import 'package:luso/widgets/GlobalAssets.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});
  static const _speechText = 'Me fale o código que enviamos no seu e-mail!';
  static const _containerColor = Color.fromARGB(255, 6, 10, 110);
  static const _speechStyle = TextStyle(
    fontSize: 12,
    fontFamily: 'Inter',
    color: Colors.white,
    decoration: TextDecoration.none,
  );

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  static const _backIconColor = Color.fromARGB(255, 0, 3, 95);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ),
                const _SpeechBubbleRow(),
                const SizedBox(height: 32),
                const _CodeInputField(),
                const SizedBox(height: 32),
                Assets().elbutton(
                  'Enviar',
                  () {
                    // Lógica de envio do código aqui
                  },
                  const Color.fromARGB(255, 0, 5, 145),
                  400,
                ),
                // Aqui você pode adicionar o formulário de recuperação de senha
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
          width: 260,
          height: 55,
          decoration: BoxDecoration(
            color: ForgetPasswordPage._containerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 12.0, left: 16.0),
            child: Text(
              ForgetPasswordPage._speechText,
              style: ForgetPasswordPage._speechStyle,
            ),
          ),
        ),
      ],
    );
  }
}

class _CodeInputField extends StatelessWidget {
  const _CodeInputField();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 4, 63),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Padding(
        padding: EdgeInsets.all(2.0),
        child: TextField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide.none,
            ),
            hintText: 'Digite o código aqui',
          ),
        ),
      ),
    );
  }
}
