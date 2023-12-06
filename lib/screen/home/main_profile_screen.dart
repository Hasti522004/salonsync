import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/controller/screen_controller/profile_controller.dart';
import 'package:salonsync/services/firebase_operations.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/common_bottom_navigation_bar.dart';
import 'package:salonsync/widgets/sidebar_widget.dart';
import 'package:salonsync/widgets/textfeild_widget.dart';

class MainProfilePage extends StatelessWidget {
  
  final _BottomNavbarIndexController = Get.find<BottomNavbarIndexController>();
  final EditProfileController editProfileController =
      Get.put(EditProfileController());
  final FirebaseOperation firebaseOperation = FirebaseOperation();

  @override
  Widget build(BuildContext context) {
    // Get the current user from Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: CommonAppBar(
        title: 'Profile',
      ),
      endDrawer: CommonDrawer(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: () async {
          String? userId = await firebaseOperation
              .getUserIdByPhoneNumber(user?.phoneNumber ?? '');
          return firebaseOperation.getUserData(userId ?? '');
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            Map<String, dynamic> userData = snapshot.data ?? {};
            String photoUrl = userData['photoUrl'] ?? '';

            return SingleChildScrollView(
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
                        backgroundImage:
                            photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
                        child: photoUrl.isEmpty
                            ? Icon(Icons.person, size: 50, color: Colors.white)
                            : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    buildEditableField(
                      'Name',
                      editProfileController.name,
                      userData['name'] ?? 'Enter your name',
                    ),
                    SizedBox(height: 10),
                    buildEditableField(
                      'Address',
                      editProfileController.address1,
                      userData['address1'] ?? 'Enter your address',
                    ),
                    SizedBox(height: 10),
                    buildEditableField(
                      'Address 2',
                      editProfileController.address2,
                      userData['address2'] ?? 'Enter your address 2',
                    ),
                    SizedBox(height: 10),
                    buildEditableField(
                      'Phone Number',
                      editProfileController.phoneNumber,
                      user?.phoneNumber ?? 'Enter your phone number',
                      keyboardType: TextInputType.phone,
                      enabled: false, // Disable editing phone number
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // Save the edited profile data
                        await saveProfileChanges(user?.phoneNumber ?? '');
                        print("User ID is : ${user?.uid ?? ''}");
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: CommonBottomNavigationBar(
        currentIndex: _BottomNavbarIndexController.currentIndex.value,
        onTap: (index) {
          _BottomNavbarIndexController.currentIndex.value = index;
        },
      ),
    );
  }

  Widget buildEditableField(String label, RxString value, String hint,
      {TextInputType? keyboardType, bool enabled = true}) {
    return TextFieldWidget(
      label: label,
      hint: hint,
      controller: TextEditingController(text: value.value),
      onChanged: (newValue) => value.value = newValue,
      keyboardType: keyboardType,
      enabled: enabled,
      validator: (value) {
        if (label == 'Name' && (value == null || value.isEmpty)) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Future<void> saveProfileChanges(String phoneNumber) async {
    try {
      // Get the user ID from the Firestore collection
      String? userId =
          await firebaseOperation.getUserIdByPhoneNumber(phoneNumber);
      print("User ID : ${userId}");
      if (userId != null) {
        // Update the user profile in Firebase using the retrieved user ID
        await firebaseOperation.updateUserProfile(
          userId,
          name: editProfileController.name.value,
          address1: editProfileController.address1.value,
          address2: editProfileController.address2.value,
        );

        // Show a snackbar upon successful update
        Get.snackbar('Success', 'Profile updated successfully',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'User not found',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (error) {
      print('Error updating profile: $error');
      Get.snackbar('Error', 'Failed to update profile',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
