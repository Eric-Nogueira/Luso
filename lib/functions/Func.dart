import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Func {
  static String? token;

  Future<int> sendViaPost(
    String email,
    String name,
    String password,
    String confirmPassword,
  ) async {
    try {
      final url = Uri.parse('${dotenv.env['API_URL']!}/user/new');

      if (email.isEmpty ||
          name.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
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
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'name': name,
            'password': sha256.convert(utf8.encode(password)).toString(),
          }),
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

  Future<int> login(String email, String password) async {
    try {
      final url = Uri.parse('${dotenv.env['API_URL']!}/user/login');

      if (email.isEmpty || password.isEmpty) {
        print('Todos os campos são obrigatórios');
        return 1;
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        print('Formato de email inválido');
        return 2;
      } else {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'password': sha256.convert(utf8.encode(password)).toString(),
          }),
        );

        print('POST ${url.toString()} -> ${response.statusCode}');
        print(response.body);

        if (response.statusCode < 200 || response.statusCode >= 300) {
          return 3;
        }

        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          return 0;
        } else {
          print('Credenciais inválidas');
          return 4;
        }
      }
    } catch (e) {
      print('Erro ao enviar dados: $e');
      return 5;
    }
  }

  Future<int> sendEmail(String email) async {
    try {
      final url = Uri.parse('${dotenv.env['API_URL']!}/user/code');

      if (email.isEmpty) {
        print("Insira um email");
        return 1;
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        print("Insira um e-mail válido");
        return 2;
      } else {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email}),
        );

        print('POST ${url.toString()} -> ${response.statusCode}');
        print(response.body);

        if (response.statusCode < 200 || response.statusCode >= 300) {
          return 3;
        }

        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          token = responseData['received']['token']?.toString();
          return 0;
        } else if (responseData['status'] == 'failed') {
          print('Erro ao enviar o e-mail de recuperação');
          return 4;
        } else {
          print("E-mail ausente no banco de dados");
          return 5;
        }
      }
    } catch (e) {
      print("Erro: $e");
      return 6;
    }
  }

  Future<int> checkCode(int code) async {
    try {
      final url = Uri.parse('${dotenv.env['API_URL']!}/user/check');
      if (code.isNaN) {
        return 1;
      } else if (token == null || token!.isEmpty) {
        print('Token de recuperação indisponível');
        return 6;
      } else {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'code': code.toString(), 'token': token}),
        );

        print('POST ${url.toString()} -> ${response.statusCode}');
        print(response.body);

        if (response.statusCode < 200 || response.statusCode >= 300) {
          return 2;
        }

        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          return 0;
        } else if (responseData['status'] == 'failed') {
          print('Código errado');
          print(code);
          print(token);
          return 3;
        } else {
          print("Erro ao enviar dados");
          return 4;
        }
      }
    } catch (e) {
      print("Erro: $e");
      return 5;
    }
  }
}
