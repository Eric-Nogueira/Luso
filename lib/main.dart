import 'package:flutter/material.dart';
import 'package:luso/AppWidget.dart';
import 'package:luso/DependencyInjection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DependencyInjection.init();
  runApp(const MyApp());
}
