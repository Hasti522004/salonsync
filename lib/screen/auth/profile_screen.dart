// lib/screen/auth/profile_screen.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salonsync/controller/auth/login_conroller.dart';
import 'package:salonsync/controller/auth/profile_controller.dart';
import 'package:salonsync/controller/userid_record.dart';
import 'package:salonsync/screen/home/home_screen.dart';
import 'package:salonsync/services/firebase_operations.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController _profileController = Get.find<ProfileController>();
  final LoginController _authController = Get.find<LoginController>();
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseOperation firebaseOperation =
      FirebaseOperation(); // Create an instance
  late File pickedFile;
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
                pickedFile = await pickImage();
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
                try {
                  String? photoUrl =
                      await firebaseOperation.uploadImage(pickedFile, 'user');

                  if (photoUrl != null) {
                    await firebaseOperation.addUserData(
                      name: _profileController.name.value,
                      photoUrl: photoUrl,
                      password: _profileController.password.value,
                      phoneNumber: _authController.phone.value,
                    );
                    UserManager.setUserId(firebaseOperation
                            .getUserIdByPhoneNumber(_authController.phone.value)
                        as String?);
                    Get.offAll(HomeScreen());
                  } else {
                    // Handle the case when image upload fails or download URL is not obtained
                    print('Image upload failed or URL not obtained.');
                    // You can show a toast or error message to the user
                  }
                } catch (e) {
                  print('Error: $e');
                }
              },
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }

  Future<File> pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _profileController.addPhoto(File(pickedFile.path));
      return File(pickedFile.path);
    } else {
      throw Exception('Image pick failed');
    }
  }
}
