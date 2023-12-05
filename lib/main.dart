import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/binding/app_binding.dart';
import 'package:salonsync/controller/theme_controller.dart';
import 'package:salonsync/route/route.dart';
import 'package:salonsync/screen/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.themeData,
        // initialRoute: '/login',
        getPages: AppRoutes.routes,
        initialBinding: AppBindings(),
        home: HomeScreen());
  }
}
