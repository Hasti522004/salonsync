// lib/screen/auth/profile_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salonsync/controller/auth/login_conroller.dart';
import 'package:salonsync/controller/auth/profile_controller.dart';
import 'package:salonsync/screen/home/home_screen.dart';
import 'package:salonsync/services/firebase_operations.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController _profileController = Get.find<ProfileController>();
  final LoginController _authController = Get.find<LoginController>();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() => CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileController.photoUrl.isNotEmpty
                      ? FileImage(File(_profileController.photoUrl.value))
                      : null,
                  child: _profileController.photoUrl.isEmpty
                      ? Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                )),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await pickImage();
              },
              child: Text('Add/Change Photo'),
            ),
            SizedBox(height: 16),
            TextField(
              onChanged: (value) => _profileController.addName(value),
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true, // Hide the password
              onChanged: (value) => _profileController.addPassword(value),
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                FirebaseOperation firebaseOperation =
                    FirebaseOperation(); // Create an instance
                await firebaseOperation.addUserData(
                  name: _profileController.name.value,
                  photoUrl: _profileController.photoUrl.value,
                  password: _profileController.password.value,
                  phoneNumber: _authController.phone.value,
                  // Add other fields as needed
                );
                Get.offAll(HomeScreen());
              },
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery); // Use pickImage instead of getImage
    if (pickedFile != null) {
      _profileController.addPhoto(File(pickedFile.path));
    }
  }
}
