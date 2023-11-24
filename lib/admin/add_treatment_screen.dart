// add_treatment_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salonsync/controller/admin_controller/add_treatment_controller.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/screen/home/home_screen.dart';
import 'package:salonsync/services/firebase_operations.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/common_bottom_navigation_bar.dart';

class AddTreatmentScreen extends StatelessWidget {
  final AddTreatmentController _controller =
      Get.put(AddTreatmentController()); // Use put to create a new instance
  final _BottomNavbarIndexController = Get.find<BottomNavbarIndexController>();
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseOperation _firebaseFunctions = FirebaseOperation();
  String imageUrl = "";

  AddTreatmentScreen({Key? key}) : super(key: key);

  Future<XFile?> pickImage() async {
    try {
      return await _imagePicker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Add Treatment'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  XFile? image = await pickImage();
                  if (image != null) {
                    print("Image Path is: ${image.path}");
                    imageUrl = (await _firebaseFunctions.uploadImage(
                        File(image.path), "treatment"))!;
                    print("Image Found: $imageUrl");
                  }
                } catch (e) {
                  print("Error picking/uploading image: $e");
                }
              },
              child: Text("Pick Image"),
            ),
            Obx(() => Text("URL : ${_controller.imageUrl.value}")),
            TextField(
              controller: _controller.treatmentNameController,
              decoration: InputDecoration(labelText: 'Treatment Name'),
            ),
            TextField(
              controller: _controller.priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: _controller.durationController,
              decoration: InputDecoration(labelText: 'Duration'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _firebaseFunctions.addTreatment(
                    _controller.treatmentNameController.text,
                    double.parse(_controller.priceController.text),
                    _controller.durationController.text,
                    imageUrl,
                  );
                  _controller.clearForm();

                  // Show success message
                  Get.snackbar(
                    'Treatment Added',
                    'Treatment added successfully!',
                    backgroundColor: Colors.green,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(seconds: 2),
                  );

                  // Redirect to home page after a delay
                  Future.delayed(Duration(seconds: 2), () {
                    // Replace this with the screen where you want to navigate after adding treatment
                    // For example:
                    Get.to(HomeScreen());
                  });
                } catch (e) {
                  print('Error adding treatment: $e');
                }
              },
              child: Text("Add Treatment to Firebase"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CommonBottomNavigationBar(
        currentIndex: _BottomNavbarIndexController.currentIndex.value,
        onTap: (index) {
          _BottomNavbarIndexController.currentIndex.value = index;
        },
      ),
    );
  }
}
