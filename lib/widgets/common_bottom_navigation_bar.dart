import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/controller/theme_controller.dart';
import 'package:salonsync/route/route.dart';
import 'package:salonsync/utils/colors.dart';

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
    final themeController = Get.find<ThemeController>();

    return Container(
      decoration: BoxDecoration(
        color: themeController.isThemeGreen.value
            ? AppColors.themeGreen
            : const Color.fromARGB(255, 20, 20, 20),
      ),
      // color: Colors.black,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          Get.find<BottomNavbarIndexController>().currentIndex.value = index;
          switch (index) {
            case 0:
              Get.toNamed(AppRoutes.homeScreen);
              break;
            case 1:
              Get.toNamed(AppRoutes.mainprofilePage);
              break;
            case 2:
              Get.toNamed(AppRoutes.addSalonPage);
              break;
            case 3:
              Get.toNamed(AppRoutes.treatmentScreen);
              break;

            default:
              Get.toNamed(AppRoutes.homeScreen);
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
            icon: Icon(Icons.add),
            label: 'Add Salon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
        selectedItemColor: themeController.isThemeGreen.value
            ? AppColors.themeBrown
            : const Color.fromARGB(255, 24, 23, 22),
        unselectedItemColor: themeController.isThemeGreen.value
            ? AppColors.themeBrown.withOpacity(0.5)
            : const Color.fromARGB(255, 16, 15, 15).withOpacity(0.5),
      ),
    );
  }
}
