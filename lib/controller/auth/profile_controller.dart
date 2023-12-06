import 'dart:io';

import 'package:get/get.dart';

class ProfileController extends GetxController {
  var name = ''.obs;
  var address = ''.obs;
  var photoUrl = ''.obs;

  String? validateName() {
    if (name.isEmpty) {
      return 'Name cannot be empty';
    }
    // You can add more specific validation rules for the name if needed
    return null;
  }

 

  void addName(String newName) {
    name.value = newName;
  }

  void addaddress(String newaddress) {
    address.value = newaddress;
  }

  void addPhoto(File? newPhoto) {
    photoUrl.value = newPhoto?.path ?? '';
  }
}
