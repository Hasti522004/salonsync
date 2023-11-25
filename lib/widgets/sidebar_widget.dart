import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/userid_record.dart';
import 'package:salonsync/route/route.dart';
import 'package:salonsync/services/firebase_operations.dart';

class CommonDrawer extends StatelessWidget {
  final FirebaseOperation _firebaseFunctions = FirebaseOperation();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                color: Color.fromARGB(255, 108, 104, 102),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 24,
                  ),
                ),
              ),
              buildDrawerItem('Profile', Icons.person, () {
                Get.toNamed(AppRoutes.mainprofilePage);
              }),
              buildDrawerItem('Theme', Icons.palette, () {
                // Handle theme change
              }),
              buildDrawerItem('Language', Icons.language, () {
                // Handle language change
              }),
              buildLogoutItem(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerItem(String title, IconData icon, Function onTap) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          SizedBox(width: 16),
          Text(title),
        ],
      ),
      onTap: () => onTap(),
    );
  }

  Widget buildLogoutItem() {
    return ListTile(
      title: Row(
        children: [
          Icon(Icons.exit_to_app),
          SizedBox(width: 16),
          Text('Logout'),
        ],
      ),
      onTap: () => _showLogoutConfirmationDialog(),
    );
  }

  void _showLogoutConfirmationDialog() {
    Get.defaultDialog(
      title: 'Logout Confirmation',
      content: Text('Are you sure you want to logout?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Handle logout
            _logout();
            Get.back(); // Close the confirmation dialog
          },
          child: Text('Logout'),
        ),
        TextButton(
          onPressed: () {
            Get.back(); // Close the confirmation dialog
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  void _logout() async {
    try {
      // Delete user data from the database

      await _firebaseFunctions.deleteUserData("${UserManager.userId}");

      // Add logic to perform logout actions, such as clearing user credentials or tokens
      // For example, if you're using GetStorage for authentication, you might do:
      // GetStorage().remove('token');

      // Redirect to the login screen
      Get.offAllNamed(
          '/login'); // Replace '/login' with the actual route for your login screen
    } catch (e) {
      print('Error during logout: $e');
      // Handle the error (show a message or log it)
    }
  }
}
