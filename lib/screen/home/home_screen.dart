import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/model/salon_card_model.dart';
import 'package:salonsync/screen/home/treatment_screen.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/common_bottom_navigation_bar.dart';
import 'package:salonsync/widgets/salon_card.dart';
import 'package:salonsync/widgets/sidebar_widget.dart';

class HomeScreen extends StatelessWidget {
  final _BottomNavbarIndexController = Get.find<BottomNavbarIndexController>();

  @override
  Widget build(BuildContext context) {
    List<Widget> cardWidgets = [];
    for (int i = 0; i < 20; i++) {
      SalonCard card = SalonCard(
        image: 'assets/images/first.jpg',
        salonName: 'Salon $i',
        address: 'Address $i',
        rating: 4.5,
        likeCount: 10,
        onTap: () {
          // Navigate to TreatmentScreen and pass salon details
          Get.to(
            () => TreatmentScreen(),
            arguments: {'salonName': 'Salon $i'},
          );
        },
      );
      cardWidgets.add(SalonbuildCardWidget(context, card, () {
        Get.to(
            () => TreatmentScreen(),
            arguments: {'salonName': 'Salon $i'},
          );
        print('Salon card tapped!');
      }));
    }

    return Scaffold(
      appBar: CommonAppBar(title: "Salon-List"),
      drawer: CommonDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: cardWidgets,
            ),
          )
        ],
      ),
      bottomNavigationBar: CommonBottomNavigationBar(
        currentIndex: _BottomNavbarIndexController.currentIndex.value,
        onTap: (index) {
          _BottomNavbarIndexController.currentIndex.value = index;
        },
      ),
    );
  }
}
