// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/controller/screen_controller/salon_list_controller.dart';
import 'package:salonsync/controller/theme_controller.dart';
import 'package:salonsync/model/salon_card_model.dart';
import 'package:salonsync/screen/home/treatment_screen.dart';
import 'package:salonsync/services/firebase_operations.dart';
import 'package:salonsync/utils/colors.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/common_bottom_navigation_bar.dart';
import 'package:salonsync/widgets/salon_card.dart';
import 'package:salonsync/widgets/sidebar_widget.dart';

class HomeScreen extends StatelessWidget {
  final _BottomNavbarIndexController = Get.put(BottomNavbarIndexController());
  final FirebaseOperation _firebaseFunctions = FirebaseOperation();
  final _SalonListController = Get.put(SalonListController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return Scaffold(
          appBar: CommonAppBar(title: "Salon-List"),
          drawer: CommonDrawer(),
          body: FutureBuilder<List<Map<String, dynamic>>>(
            future: _firebaseFunctions.fetchSalons(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                List<Widget> cardWidgets = [];
                for (var salon in snapshot.data!) {
                  SalonCard card = SalonCard(
                    image: salon['imageUrl'],
                    salonName: salon['salonName'] ?? 'Unknown Salon',
                    address: salon['address'] ?? 'Unknown Address',
                    rating: (salon['rating'] ?? 0).toDouble(),
                    likeCount: salon['likeCount'] ?? 0,
                    onTap: () {
                      Get.to(
                        () => TreatmentScreen(),
                        arguments: {'salonName': salon['salonName']},
                      );
                    },
                  );
                  cardWidgets.add(SalonbuildCardWidget(context, card, () {
                    Get.to(() => TreatmentScreen(),
                        arguments: {'salonName': salon['salonName']});

                    _SalonListController.updateSelectedSalonId(salon['id']);
                    print("Salon Id: ${_SalonListController.selectedSalonId}");
                    print('Salon card tapped!');
                  }));
                }
                return Container(
                  // Add a Container for background color
                  width: double.infinity,
                  color: themeController.isThemeGreen.value
                      ? AppColors.white
                      : AppColors.black,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: cardWidgets,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          bottomNavigationBar: Container(
            color: Colors.black, // Set the background color to black
            child: CommonBottomNavigationBar(
              currentIndex: _BottomNavbarIndexController.currentIndex.value,
              onTap: (index) {
                _BottomNavbarIndexController.currentIndex.value = index;
              },
            ),
          ),
        );
      },
    );
  }
}
