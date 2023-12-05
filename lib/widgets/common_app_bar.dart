import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/theme_controller.dart';
import 'package:salonsync/utils/colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CommonAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return AppBar(
          title: Text(title),
          actions: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
            // Add additional widgets for the trailing content as needed
          ],
          backgroundColor: themeController.isThemeGreen.value
              ? AppColors.themeGreen
              : Color.fromARGB(255, 23, 23, 23),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
