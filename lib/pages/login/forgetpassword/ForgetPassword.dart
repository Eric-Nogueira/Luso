import 'package:flutter/material.dart';
import 'package:luso/functions/Func.dart';
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
  static const cases = {
    0: 'Sucesso',
    1: 'Insira o código',
    2: 'Erro ao enviar dados. Tente novamente mais tarde',
    3: 'O código errado. Cheque e tente novamente',
    4: 'Erro ao enviar dados. Tente novamente mais tarde',
    5: 'Erro ao enviar dados. Tente novamente mais tarde',
  };

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  static const _backIconColor = Color.fromARGB(255, 0, 3, 95);
  final TextEditingController _codecontroller = TextEditingController();

  Future<void> checkCode() async {
    try {
      final result = await Func().checkCode(int.parse(_codecontroller.text));
      if (result != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar (
            backgroundColor: const Color.fromARGB(255, 128, 9, 0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
            content: Text(ForgetPasswordPage.cases[result] ?? 'Erro'),
          ),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar (backgroundColor: const Color.fromARGB(255, 0, 128, 0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))), content: Text('Cadastro realizado com sucesso!')),
        );
        //Navigator.pushReplacementNamed(context, '/update_password');
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
                const _CodeInputField(),
                const SizedBox(height: 32),
                Assets().elbutton(
                  'Enviar',
                  () async {
                    await checkCode(); // Lógica de envio do código aqui
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
      child: Padding(
        padding: EdgeInsets.all(2.0),
        child: TextField(
          controller: context
              .findAncestorStateOfType<_ForgetPasswordPageState>()
              ?._codecontroller,
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
