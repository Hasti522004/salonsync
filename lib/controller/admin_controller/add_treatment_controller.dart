import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTreatmentController extends GetxController {
  RxString imageUrl = RxString("");

  final TextEditingController treatmentNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  // Function to clear all text controllers
  void clearForm() {
    treatmentNameController.clear();
    priceController.clear();
    durationController.clear();
    imageUrl.value = "";
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is closed
    treatmentNameController.dispose();
    priceController.dispose();
    durationController.dispose();
    super.onClose();
  }
}