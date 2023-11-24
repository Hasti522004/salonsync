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
  String imageUrl = "";

  AddSalonScreen({super.key});
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
      appBar: CommonAppBar(title: 'Add Salon'),
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
                        File(image.path), "salon"))!;
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
                  await _firebaseFunctions.addSalon(
                      _controller.salonNameController.text,
                      _controller.addressController.text,
                      int.parse(_controller.ratingController.text),
                      int.parse(_controller.likeCountController.text),
                      imageUrl);
                  _controller.clearForm();

                  // Show success message
                  Get.snackbar(
                    'Salon Added',
                    'Salon added successfully!',
                    backgroundColor: Colors.green,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(seconds: 2),
                  );

                  // Redirect to home page after a delay
                  Future.delayed(Duration(seconds: 2), () {
                    Get.to(HomeScreen());
                  });
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
