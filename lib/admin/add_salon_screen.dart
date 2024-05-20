import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salonsync/controller/admin_controller/add_salon_controller.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/services/firebase_operations.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/sidebar_widget.dart';

import '../screen/home/home_screen.dart';

class AddSalonScreen extends StatelessWidget {
  final AddSalonController _controller = Get.find<AddSalonController>();
  final _bottomNavbarIndexController = Get.find<BottomNavbarIndexController>();
  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseOperation _firebaseFunctions = FirebaseOperation();
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
      backgroundColor: Colors.black,
      appBar: CommonAppBar(title: 'Add Salon'),
      endDrawer: CommonDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                      borderRadius: BorderRadius.circular(
                          10.0), // Set border radius for the button
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller.salonNameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Salon Name',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter salon name',
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
                controller: _controller.addressController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter salon address',
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
                controller: _controller.ratingController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Rating',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter salon rating',
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
                controller: _controller.likeCountController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Like Count',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter like count',
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
                          pickedFile, 'salon');
                      if (photoUrl != null) {
                        await _firebaseFunctions.addSalon(
                          _controller.salonNameController.text,
                          _controller.addressController.text,
                          int.parse(_controller.ratingController.text),
                          int.parse(_controller.likeCountController.text),
                          photoUrl,
                        );
                        _controller.clearForm();

                        Get.snackbar(
                          'Salon Added',
                          'Salon added successfully!',
                          backgroundColor: Colors.green,
                          snackPosition: SnackPosition.BOTTOM,
                          duration: Duration(seconds: 2),
                        );

                        Future.delayed(Duration(seconds: 2), () {
                          Get.offAll(HomeScreen());
                        });
                      } else {
                        print('Image upload failed or URL not obtained.');
                      }
                    } catch (e) {
                      print('Error adding salon: $e');
                    }
                  },
                  child: Container(
                    width: double.infinity, // Set the width to the maximum
                    padding:
                        EdgeInsets.symmetric(vertical: 15), // Adjust padding
                    child: Center(
                      child: Text(
                        "Add Salon",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 78, 150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set border radius for the button
                    ),
                  ),
                ),
              ),
            ],
          ),
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
