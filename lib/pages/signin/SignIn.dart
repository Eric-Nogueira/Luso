import 'package:flutter/material.dart';
import 'package:luso/widgets/GlobalAssets.dart';
import 'package:luso/functions/Func.dart';

class SigninPage extends StatefulWidget {
  static const cases = {
    0: 'Sucesso',
    1: 'Todos os campos são obrigatórios',
    2: 'As senhas não coincidem',
    3: 'A senha deve conter pelo menos 8 caracteres',
    4: 'Formato de email inválido',
    5: 'Falha ao enviar dados, tente novamente mais tarde',
    6: 'Erro ao enviar dados, tente novamente mais tarde',
    7: 'Email já cadastrado, use outro email ou faça login',
  };
  const SigninPage({super.key});
  static const _emailHint = 'E-mail';
  static const _nameHint = 'Nome';
  static const _passwordHint = 'Senha';
  static const _confirmPasswordHint = 'Confirme sua senha';
  static const _speechText = 'Me fale seu nome, e-mail e escolha uma senha!';
  static const _backIconColor = Color.fromARGB(255, 0, 3, 95);
  static const _containerColor = Color.fromARGB(255, 6, 10, 110);
  static const _speechStyle = TextStyle(
    fontSize: 14,
    fontFamily: 'Inter',
    color: Colors.white,
    decoration: TextDecoration.none,
  );

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Future<void> sendViaPost() async {
    try {
      final result = await Func().sendViaPost(
        _emailController.text,
        _nameController.text,
        _passwordController.text,
        _confirmPasswordController.text,
      );
      if (result != 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar (backgroundColor: const Color.fromARGB(255, 128, 9, 0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))), content: Text(SigninPage.cases[result]!)),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar (backgroundColor: const Color.fromARGB(255, 0, 128, 0), shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))), content: Text('Cadastro realizado com sucesso!')),
        );
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      color: SigninPage._backIconColor,
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
                  'Continuar',
                  () async {
                    await sendViaPost(); // Lógica de login aqui
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
          height: 60,
          decoration: BoxDecoration(
            color: SigninPage._containerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 12.0, left: 16.0),
            child: Text(SigninPage._speechText, style: SigninPage._speechStyle),
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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _NameTextField(),
          SizedBox(height: 16),
          _EmailTextField(),
          SizedBox(height: 16),
          _PasswordTextField(),
          SizedBox(height: 16),
          _ConfirmPasswordTextField(),
        ],
      ),
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
        controller: context
            .findAncestorStateOfType<_SigninPageState>()
            ?._emailController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: SigninPage._emailHint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _NameTextField extends StatelessWidget {
  const _NameTextField();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 6, 10, 110),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: context
            .findAncestorStateOfType<_SigninPageState>()
            ?._nameController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: SigninPage._nameHint,
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 6, 10, 110),
            borderRadius: BorderRadius.circular(14),
          ),
          child: TextField(
            controller: context
                .findAncestorStateOfType<_SigninPageState>()
                ?._passwordController,
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: SigninPage._passwordHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConfirmPasswordTextField extends StatelessWidget {
  const _ConfirmPasswordTextField();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 6, 10, 110),
            borderRadius: BorderRadius.circular(14),
          ),
          child: TextField(
            controller: context
                .findAncestorStateOfType<_SigninPageState>()
                ?._confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: SigninPage._confirmPasswordHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
