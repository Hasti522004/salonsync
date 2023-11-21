import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salonsync/binding/app_binding.dart';
import 'package:salonsync/screen/auth/login_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),
        // Add more routes as needed
      ],
      initialBinding: AppBindings(),
    );
  }
}
