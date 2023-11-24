import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salonsync/controller/admin_controller/add_salon_controller.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/services/firebase_operations.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/common_bottom_navigation_bar.dart';

import '../screen/home/home_screen.dart';

class AddSalonScreen extends StatelessWidget {
  final AddSalonController _controller = Get.find<AddSalonController>();
  final _BottomNavbarIndexController = Get.find<BottomNavbarIndexController>();
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseOperation _firebaseFunctions = FirebaseOperation();
  // String imageUrl = "";
  late File pickedFile;

  AddSalonScreen({super.key});
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
      appBar: CommonAppBar(title: 'Add Salon'),
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
              controller: _controller.salonNameController,
              decoration: InputDecoration(labelText: 'Salon Name'),
            ),
            TextField(
              controller: _controller.addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _controller.ratingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Rating'),
            ),
            TextField(
              controller: _controller.likeCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Like Count'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  String? photoUrl =
                      await _firebaseFunctions.uploadImage(pickedFile, 'salon');
                  if (photoUrl != null) {
                    await _firebaseFunctions.addSalon(
                        _controller.salonNameController.text,
                        _controller.addressController.text,
                        int.parse(_controller.ratingController.text),
                        int.parse(_controller.likeCountController.text),
                        photoUrl);
                    _controller.clearForm();

                    Get.snackbar(
                      'Salon Added',
                      'Salon added successfully!',
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: Duration(seconds: 2),
                    );

                    // Redirect to home page after a delay
                    Future.delayed(Duration(seconds: 2), () {
                      Get.offAll(HomeScreen());
                    });
                  }
                  // Show success message
                  else {
                    // Handle the case when image upload fails or download URL is not obtained
                    print('Image upload failed or URL not obtained.');
                    // You can show a toast or error message to the user
                  }
                } catch (e) {
                  print('Error adding salon: $e');
                }
              },
              child: Text("Add Salon to Firebase"),
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
