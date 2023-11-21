import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/route/route.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CommonBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            Get.toNamed(AppRoutes.homeScreen); // Use the route name
            break;
          case 1:
            Get.toNamed(AppRoutes.appointmentBooking); // Use the route name
            break;
          case 2:
            Get.toNamed(AppRoutes.treatmentScreen); // Use the route name
            break;
          default:
            Get.toNamed(AppRoutes.homeScreen); // Use the route name
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
        // Add more items as needed
      ],
    );
  }
}
