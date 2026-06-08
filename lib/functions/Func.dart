//import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Func {
  Future<void> sendViaPost(String email, String name, String password, String confirmPassword) async {
    try {
      final url = Uri.parse('${dotenv.env['API_URL']!}/newUser.php');

      if (email.isEmpty || name.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        print('Todos os campos são obrigatórios');
        return;
      } else if (password != confirmPassword) {
        print('As senhas não coincidem');
        return;
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        print('Formato de email inválido');
        return;
      } else {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'name': name, 'password': sha256.convert(utf8.encode(password)).toString()}),
        );
        return;
      }
    } catch (e) {
      print('Erro ao enviar dados: $e');
    }
  }
}
