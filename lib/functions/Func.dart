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
      final url = Uri.parse('https://luso-backend-api.onrender.com/user/new');

      if (email.isEmpty ||
          name.isEmpty ||
          password.isEmpty ||
          confirmPassword.isEmpty) {
        return 1;
      } else if (password != confirmPassword) {
        return 2;
      } else if (password.length < 8) {
        return 3;
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        return 4;
      } else {
        final response = await http
            .post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'email': email,
                'name': name,
                'password': sha256.convert(utf8.encode(password)).toString(),
              }),
            )
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                return http.Response('Tempo limite de conexão atingido', 408);
              },
            );

        print('POST ${url.toString()} -> ${response.statusCode}');
        print(response.body);

        if (response.body.toString().contains('Usuário já cadastrado')) {
          return 7;
        }

        if (response.statusCode < 200 || response.statusCode >= 300) {
          return 5;
        }

        return 0;
      }
    } catch (e) {
      return 6;
    }
  }

  Future<int> login(String email, String password) async {
    try {
      final url = Uri.parse('https://luso-backend-api.onrender.com/user/login');

      if (email.isEmpty || password.isEmpty) {
        return 1;
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        return 2;
      } else {
        final response = await http
            .post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'email': email,
                'password': sha256.convert(utf8.encode(password)).toString(),
              }),
            )
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                return http.Response('Tempo limite de conexão atingido', 408);
              },
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
          return 4;
        }
      }
    } catch (e) {
      return 5;
    }
  }

  static Future<Map<String, dynamic>?> getQuestionsForFase(
    int fase, {
    List<String> exclude = const [],
  }) async {
    try {
      final url = Uri.parse(
        'https://luso-backend-api.onrender.com/questions/fase',
      );

      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'fase': fase, 'exclude': exclude}),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              return http.Response('Tempo limite de conexão atingido', 408);
            },
          );

      print('POST ${url.toString()} -> ${response.statusCode}');
      print(response.body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        return null;
      }

      final responseData = jsonDecode(response.body);
      if (responseData['status'] == 'success') {
        return responseData;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
