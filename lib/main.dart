import 'package:flutter/material.dart';
import 'customer/screen/home_screen.dart';
import 'login/login_screen.dart';
import 'login/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Signup_Screen(),
    );
  }
}
