import 'dart:io';

import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var password = ''.obs;
  var photoUrl = ''.obs;

  void addName(String newName) {
    name.value = newName;
  }

  void addPassword(String newPassword) {
    password.value = newPassword;
  }

  void addPhoto(File newPhoto) {
    photoUrl.value = newPhoto.path; // Corrected variable access
  }
}
