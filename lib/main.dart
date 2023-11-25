import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/binding/app_binding.dart';
import 'package:salonsync/route/route.dart';
import 'package:salonsync/screen/Splash_screen.dart';

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
        // initialRoute: '/login',
        getPages: AppRoutes.routes,
        initialBinding: AppBindings(),
        home: SplashScreen());
  }
}
