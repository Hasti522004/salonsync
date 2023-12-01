import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:salonsync/utils/colors.dart';

class ThemeController extends GetxController {
  final RxBool isThemeGreen = false.obs;

  @override
  void onInit() {
    // Set the default theme to black when the controller is initialized
    updateTheme(isThemeGreen.value ? AppColors.themeGreen : AppColors.black);
    super.onInit();
  }

  void toggleTheme() {
    isThemeGreen.value = !isThemeGreen.value;
    // Update the theme based on the new toggle value
    updateTheme(isThemeGreen.value ? AppColors.themeGreen : AppColors.black);
  }

  void updateTheme(Color themeColor) {
    // Save the selected theme color to GetStorage for persistence
    GetStorage().write('themeColor', themeColor.value);

    // Update the theme dynamically
    Get.changeTheme(
      ThemeData(
        primaryColor: themeColor,
      ),
    );
  }

  ThemeData get themeData => ThemeData(
        primaryColor:
            isThemeGreen.value ? AppColors.themeGreen : AppColors.black,
      );
}
