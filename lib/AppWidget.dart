import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:luso/pages/results/PerformancePage.dart';
import 'package:luso/pages/results/PerfectResultPage.dart';
import 'pages/PresentationPage.dart';
import 'package:luso/pages/HomePage.dart';
import 'package:luso/pages/SplashScreen.dart';
import 'package:luso/pages/login/Login.dart';
import 'package:luso/pages/login/forgetpassword/ForgetPassword.dart';
import 'package:luso/pages/signin/SignIn.dart';
import 'package:luso/pages/login/forgetpassword/SendEmail.dart';
import 'package:luso/pages/QuestionPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
        '/questions': (context) {
        final args = ModalRoute.of(context)?.settings.arguments;

         int initialQuestion = 1;
         bool reviewMode = false;

         if (args is Map) {
          initialQuestion =
          args['initialQuestion'] ?? 1;

          reviewMode =
            args['reviewMode'] ?? false;
  }

  return QuestionPage(
    initialQuestion: initialQuestion,
    reviewMode: reviewMode,
  );
},
        '/perfect_result': (context) => const PerfectResultPage(),

        '/performance': (context) {
          final args =
            ModalRoute.of(context)?.settings.arguments as Map;

          return PerformancePage(
            correctAnswers: args['correctAnswers'],
            totalQuestions: args['totalQuestions'],
            wrongQuestions:
              List<int>.from(args['wrongQuestions']),
            reviewTopics:
              List<String>.from(args['reviewTopics']),
            fase: args['fase'],
          );
        },
      },
    );
  }
}