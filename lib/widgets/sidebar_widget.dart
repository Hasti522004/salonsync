import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/userid_record.dart';
import 'package:salonsync/route/route.dart';
import 'package:salonsync/services/firebase_operations.dart';

class CommonDrawer extends StatelessWidget {
  final FirebaseOperation _firebaseFunctions = FirebaseOperation();

  @override
  Widget build(BuildContext context) {
    double sidebarWidth =
        MediaQuery.of(context).size.width * 0.7; // 70% of the screen width

    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Container(
            width: sidebarWidth, // Set the width of the sidebar
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'SalonSync',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 24,
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                buildDrawerItem('Profile', Icons.person, () {
                  Get.toNamed(AppRoutes.mainprofilePage);
                }),
                FutureBuilder<bool>(
                  future: fetchIsAdmin(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == true) {
                        buildDrawerItem('Add Salon', Icons.add, () {
                          Get.toNamed(AppRoutes.addSalonPage);
                        });
                      }
                    }
                    return Container();
                  },
                ),
                buildDrawerItem('Add Salon', Icons.add, () {
                  Get.toNamed(AppRoutes.addSalonPage);
                }),
                buildDrawerItem('Add Treatment', Icons.add, () {
                  Get.toNamed(AppRoutes.addTreatmentPage);
                }),
                buildDrawerItem('Settings', Icons.settings, () {
                  // Handle settings click
                }),
                buildLogoutItem(),
              ],
            ),
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

  Future<bool> fetchIsAdmin() async {
    String userId = UserManager.userId ?? '';
    print('User ID passed to fetchIsAdmin: $userId');

    return _firebaseFunctions.fetchIsAdmin(userId);
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
      String userPhoneNumber = UserManager.userPhoneNumber ?? '';
      await _firebaseFunctions.deleteUserData("${UserManager.userId}");
      await FirebaseAuth.instance.signOut();
      print('Logout successful for user with phone number: $userPhoneNumber');
      Get.offAllNamed('/login');
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
