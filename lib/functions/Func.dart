import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Func {
  Future<int> sendViaPost(String email, String name, String password, String confirmPassword) async {
    try {
      final url = Uri.parse('${dotenv.env['API_URL']!}/newUser.php');

      if (email.isEmpty || name.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        print('Todos os campos são obrigatórios');
        return 1;
      } else if (password != confirmPassword) {
        print('As senhas não coincidem');
        return 2;
      } else if (password.length < 8) {
        print('A senha deve conter pelo menos 8 caracteres');
        return 3;
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        print('Formato de email inválido');
        return 4;
      } else {
        final response = await http.post(
          url,
          body: {
            'email': email,
            'name': name,
            'password': sha256.convert(utf8.encode(password)).toString(),
          },
        );

        print('POST ${url.toString()} -> ${response.statusCode}');
        print(response.body);

        if (response.body.toString().contains('Usuário já cadastrado')) {
          print('Email já cadastrado');
          return 7;
        }

        if (response.statusCode < 200 || response.statusCode >= 300) {
          return 5;
        }

        return 0;
      }
    } catch (e) {
      print('Erro ao enviar dados: $e');
      return 6;
    }
  }
}
