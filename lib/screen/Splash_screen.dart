import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/userid_record.dart';
import 'package:salonsync/screen/auth/login_screen.dart';
import 'package:salonsync/screen/home/home_screen.dart';
import 'package:salonsync/services/firebase_operations.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check if the user is already authenticated
    User? user = FirebaseAuth.instance.currentUser;
    final FirebaseOperation firebaseOperation =
        FirebaseOperation(); // Create an instance

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to the App"),
            ElevatedButton(
              onPressed: () async {
                // Navigate to the appropriate screen based on user authentication
                if (user != null) {
                  print("User is logged in: ${user.phoneNumber}");
                  UserManager.setUserId(await firebaseOperation
                      .getUserIdByPhoneNumber("${user.phoneNumber}"));

                
                  // User is already authenticated, navigate to HomeScreen
                  Get.off(HomeScreen());
                } else {
                  // User is not authenticated, navigate to LoginScreen
                  Get.off(LoginScreen());
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
