import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/route/route.dart';

class CommonDrawer extends StatelessWidget {
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
                Get.toNamed(AppRoutes.profilePage);
              }),
              buildDrawerItem('Theme', Icons.palette, () {
                // Handle theme change
              }),
              buildDrawerItem('Language', Icons.language, () {
                // Handle language change
              }),
              buildDrawerItem('Logout', Icons.exit_to_app, () {
                // Handle logout
              }),
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
}
