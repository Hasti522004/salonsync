import 'dart:io';

import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var password = ''.obs;
  var photoUrl = ''.obs;

  String? validateName() {
    if (name.isEmpty) {
      return 'Name cannot be empty';
    }
    // You can add more specific validation rules for the name if needed
    return null;
  }

  String? validatePassword() {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    // Add more password validation rules if needed (e.g., length, complexity)
    return null;
  }

  void addName(String newName) {
    name.value = newName;
  }

  void addPassword(String newPassword) {
    password.value = newPassword;
  }

  void addPhoto(File? newPhoto) {
    photoUrl.value = newPhoto?.path ?? '';
  }
}
