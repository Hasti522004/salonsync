import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/controller/screen_controller/treatment_controller.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/common_bottom_navigation_bar.dart';
import 'package:salonsync/widgets/sidebar_widget.dart';

class TreatmentScreen extends StatelessWidget {
  final _BottomNavbarIndexController = Get.find<BottomNavbarIndexController>();
  final TreatmentController controller = Get.put(TreatmentController());

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final String salonName = args['salonName'];

    return Scaffold(
      appBar: CommonAppBar(
        title: '$salonName',
      ),
      drawer: CommonDrawer(),
      body: GetBuilder<TreatmentController>(
        builder: (controller) {
          return ListView(
            children: controller.cardList,
          );
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
  }
}
