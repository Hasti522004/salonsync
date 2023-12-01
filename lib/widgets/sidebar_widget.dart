import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salonsync/controller/userid_record.dart';
import 'package:salonsync/route/route.dart';
import 'package:salonsync/services/firebase_operations.dart';
import 'package:salonsync/utils/colors.dart';

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
                _showThemeDialog();
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

  void _showThemeDialog() {
    Get.defaultDialog(
      title: 'Theme Selection',
      content: Column(
        children: [
          Text('Select a theme:'),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _changeTheme(AppColors.themeGreen);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.themeGreen,
            ),
            child: Text('Green Theme'),
          ),
          ElevatedButton(
            onPressed: () {
              _changeTheme(AppColors.black);
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.black,
            ),
            child: Text('Default Theme'),
          ),
        ],
      ),
    );
  }

  void _changeTheme(Color themeColor) {
    // Save the selected theme color to GetStorage for persistence
    GetStorage().write('themeColor', themeColor.value);

    // Update the theme dynamically
    Get.changeTheme(
      ThemeData(
        primaryColor: themeColor,
      ),
    );
  }

  void _showLogoutConfirmationDialog() {
    Get.defaultDialog(
      title: 'Logout Confirmation',
      content: Text('Are you sure you want to logout?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            _logout();
            Get.back();
          },
          child: Text('Logout'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  void _logout() async {
    try {
      await _firebaseFunctions.deleteUserData("${UserManager.userId}");
      Get.offAllNamed('/login');
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
