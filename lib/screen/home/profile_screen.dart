import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/screen_controller/profile_controller.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/textfeild_widget.dart';

class ProfilePage extends StatelessWidget {
  // Initialize the controller using Get.put or Get.lazyPut
  final EditProfileController editProfileController =
      Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle image upload or edit
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      'https://example.com/profile.jpg'), // Use the actual image URL
                ),
              ),
              SizedBox(height: 20),
              buildEditableField(
                'Name',
                editProfileController.name,
                'Enter your name', // Add a hint text
              ),
              SizedBox(height: 10),
              buildEditableField(
                'Address',
                editProfileController.address1,
                'Enter your address',
              ),
              SizedBox(height: 10),
              buildEditableField(
                'Address 2',
                editProfileController.address2,
                'Enter your address 2',
              ),
              SizedBox(height: 10),
              buildEditableField(
                'Phone Number',
                editProfileController.phoneNumber,
                'Enter your phone number',
                keyboardType: TextInputType.phone, // Set keyboard type to phone
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save the edited profile data
                  // You can access the edited data using editProfileController.name.value, etc.
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(String label, RxString value, String hint,
      {TextInputType? keyboardType}) {
    return TextFieldWidget(
      label: label,
      hint: hint,
      controller: TextEditingController(text: value.value),
      onChanged: (newValue) => value.value = newValue,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
