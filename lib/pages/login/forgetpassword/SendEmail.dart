import 'package:flutter/material.dart';
import 'package:luso/widgets/GlobalAssets.dart';
import 'package:luso/functions/Func.dart';

class SendEmailPage extends StatefulWidget {
  const SendEmailPage({super.key});
  static const _speechText = 'Me fale o seu e-mail para que possamos enviar um código para recuperação da senha!';
  static const _containerColor = Color.fromARGB(255, 6, 10, 110);
  static const _speechStyle = TextStyle(
    fontSize: 12,
    fontFamily: 'Inter',
    color: Colors.white,
    decoration: TextDecoration.none,
  );
  static const cases = {
    0: 'Sucesso',
    1: 'Insira um e-mail',
    2: 'Insira um e-mail válido',
    3: 'Erro ao enviar dados. Tente novamente mais tarde',
    4: 'Erro ao enviar e-mail de recuperação. Tente novamente mais tarde',
    5: 'E-mail não cadastrado no sistema. Use um e-mail já cadastrado',
    6: 'Erro ao enviar dados. Tente novamente mais tarde'
  };

  @override
  State<SendEmailPage> createState() => _SendEmailPageState();
}

class _SendEmailPageState extends State<SendEmailPage> {
  static const _backIconColor = Color.fromARGB(255, 0, 3, 95);
  final TextEditingController _emailcontroller = TextEditingController();

  Future<void> sendEmail() async {
    try {
      final result = await Func().sendEmail(_emailcontroller.text);
      if (result != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar (
            backgroundColor: const Color.fromARGB(255, 128, 9, 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
            content: Text(SendEmailPage.cases[result] ?? 'Erro'),
          ),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar (backgroundColor: const Color.fromARGB(255, 0, 128, 0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))), content: Text('E-mail enviado com sucesso!')),
        );
        Navigator.pushReplacementNamed(context, '/forget_password');
      }
    } catch (e) {
      print("Erro: $e");
    }
  }

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
                const _EmailInputField(),
                const SizedBox(height: 32),
                Assets().elbutton(
                  'Enviar',
                  () async {
                    await sendEmail();// Lógica de envio do código aqui
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
            color: SendEmailPage._containerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 12.0, left: 16.0),
            child: Text(
              SendEmailPage._speechText,
              style: SendEmailPage._speechStyle,
            ),
          ),
        ),
      ],
    );
  }
}

class _EmailInputField extends StatelessWidget {
  const _EmailInputField();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 4, 63),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: TextField(
          controller: context.findAncestorStateOfType<_SendEmailPageState>()?._emailcontroller,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide.none,
            ),
            hintText: 'Email',
          ),
        ),
      ),
    );
  }
}
