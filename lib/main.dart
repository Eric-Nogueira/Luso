import 'package:flutter/material.dart';
import 'package:luso/AppWidget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:luso/pages/SplashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(InternetController());
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
