import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/theme_controller.dart';
import 'package:salonsync/utils/colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;
  final bool showSearchBar;
  final VoidCallback? onSearchIconPressed;
  final bool showBackArrow; // Add this property

  const CommonAppBar({
    Key? key,
    required this.title,
    this.searchController,
    this.onSearchChanged,
    this.showSearchBar = false,
    this.onSearchIconPressed,
    this.showBackArrow = false, // Initialize the property
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return AppBar(
          automaticallyImplyLeading: showBackArrow, // Show back arrow
          title: showSearchBar && searchController != null
              ? TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search salon',
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                )
              : Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
          actions: [
            if (!showSearchBar)
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                onPressed: onSearchIconPressed,
              ),
            IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
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
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Adjust as needed
}
