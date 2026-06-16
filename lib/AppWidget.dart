import 'package:flutter/material.dart';
import 'pages/PresentationPage.dart';
import 'package:luso/pages/HomePage.dart';
import 'package:luso/pages/SplashScreen.dart';
import 'package:luso/pages/login/Login.dart';
import 'package:luso/pages/login/forgetpassword/ForgetPassword.dart';
import 'package:luso/pages/signin/SignIn.dart';
import 'package:luso/pages/login/forgetpassword/SendEmail.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Coolvetica',
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const SplashScreen(),
        '/presentation': (context) => const PresentationPage(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/send_email': (context) => const SendEmailPage(),
        '/forget_password': (context) => const ForgetPasswordPage(),
        '/signin': (context) => const SigninPage(),
      },
    );
  }
}