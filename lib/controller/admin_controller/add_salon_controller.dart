import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSalonController extends GetxController {

  RxString imageUrl = RxString("");

  final TextEditingController salonNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController likeCountController = TextEditingController();

  // Function to clear all text controllers
  void clearForm() {
    salonNameController.clear();
    addressController.clear();
    ratingController.clear();
    likeCountController.clear();

    imageUrl.value = "";
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is closed
    salonNameController.dispose();
    addressController.dispose();
    ratingController.dispose();
    likeCountController.dispose();
    super.onClose();
  }
}