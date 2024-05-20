import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salonsync/controller/admin_controller/add_treatment_controller.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/services/firebase_operations.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/sidebar_widget.dart';

class AddTreatmentScreen extends StatelessWidget {
  final AddTreatmentController _controller =
      Get.put(AddTreatmentController()); // Instantiate the controller
  final _bottomNavbarIndexController = Get.find<BottomNavbarIndexController>();
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseOperation _firebaseFunctions = FirebaseOperation();
  late File pickedFile;

  AddTreatmentScreen({super.key});

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
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: 'Add Treatment'),
      endDrawer: CommonDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  pickedFile = (await pickImage())!;
                },
                child: Text(
                  "Pick Image",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 78, 150, 150),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Set border radius
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller.treatmentNameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Treatment Name',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Enter treatment name',
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Set border radius for the focused border
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Set border radius for the enabled border
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller.priceController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Price',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Enter treatment price',
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _controller.durationController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Duration',
                labelStyle: TextStyle(color: Colors.white),
                hintText: 'Enter treatment duration',
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    String? photoUrl = await _firebaseFunctions.uploadImage(
                        pickedFile, 'treatment');
                    if (photoUrl != null) {
                      // Add your logic to save treatment data to Firebase
                      // using _controller.treatmentNameController.text,
                      // _controller.priceController.text,
                      // _controller.durationController.text, and photoUrl.

                      _controller.clearForm();

                      Get.snackbar(
                        'Treatment Added',
                        'Treatment added successfully!',
                        backgroundColor: Colors.green,
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 2),
                      );

                      // You can navigate to another screen or perform any other action here.
                    } else {
                      print('Image upload failed or URL not obtained.');
                    }
                  } catch (e) {
                    print('Error adding treatment: $e');
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Add Treatment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 78, 150, 150),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: CommonBottomNavigationBar(
      //   currentIndex: _bottomNavbarIndexController.currentIndex.value,
      //   onTap: (index) {
      //     _bottomNavbarIndexController.currentIndex.value = index;
      //   },
      // ),
    );
  }
}
