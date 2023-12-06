import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salonsync/controller/auth/login_conroller.dart';
import 'package:salonsync/controller/auth/profile_controller.dart';
import 'package:salonsync/screen/home/home_screen.dart';
import 'package:salonsync/services/firebase_operations.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());
  final LoginController _authController = Get.find<LoginController>();
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseOperation firebaseOperation =
      FirebaseOperation(); // Create an instance
  late File pickedFile = File(''); // Initialize to an empty file

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          child: Divider(
            color: Colors.white,
            thickness: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => CircleAvatar(
                    radius: 80,
                    backgroundImage: _profileController.photoUrl.isNotEmpty
                        ? FileImage(File(_profileController.photoUrl.value))
                        : null,
                    child: _profileController.photoUrl.isEmpty
                        ? Icon(Icons.person, size: 50, color: Colors.white)
                        : null,
                  )),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  try {
                    File? result = await pickImage();
                    if (result != null) {
                      pickedFile = result;
                    } else {
                      // Handle the case when pickedFile is null
                      // You might want to show a message to the user
                      return;
                    }
                  } catch (e) {
                    print('Error picking image: $e');
                    pickedFile = File('');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 78, 150, 150),
                ),
                child: Text(
                  'Add/Change Photo',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: (value) => _profileController.addName(value),
                decoration: InputDecoration(labelText: 'Name'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: (value) => _profileController.addaddress(value),
                decoration: InputDecoration(labelText: 'Address'),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    String? photoUrl =
                        await firebaseOperation.uploadImage(pickedFile, 'user');
                    // Proceed even if photoUrl is null, but provide a default value if it is null
                    await firebaseOperation.addUserData(
                      name: _profileController.name.value,
                      photoUrl: photoUrl ?? "",
                      address: _profileController.address.value,
                      phoneNumber: _authController.phone.value,
                    );

                    Get.offAll(HomeScreen());
                  } catch (e) {
                    print('Error: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 78, 150, 150),
                ),
                child:
                    Text('Go to Home', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _profileController.addPhoto(File(pickedFile.path));
      return File(pickedFile.path);
    } else {
      print('Image pick cancelled');
      return null;
    }
  }
}
