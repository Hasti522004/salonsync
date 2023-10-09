import 'package:flutter/material.dart';
import 'package:salonsync/customer/screen/home_screen.dart';
import 'package:salonsync/customer/screen/treatment_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ServicesScreen(),
    );
  }
}
