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
  late File pickedFile;

  AddTreatmentScreen({Key? key}) : super(key: key);

  Future<File?> pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      throw Exception('Image pick failed');
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
                pickedFile = (await pickImage())!;
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
                  String? photoUrl = await _firebaseFunctions.uploadImage(
                      pickedFile, 'treatment');
                  if (photoUrl != null) {
                    await _firebaseFunctions.addTreatment(
                      _controller.treatmentNameController.text,
                      double.parse(_controller.priceController.text),
                      _controller.durationController.text,
                      photoUrl,
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
                  } else {
                    // Handle the case when image upload fails or download URL is not obtained
                    print('Image upload failed or URL not obtained.');
                    // You can show a toast or error message to the user
                  }
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
