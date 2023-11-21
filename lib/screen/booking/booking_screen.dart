import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/route/route.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/common_bottom_navigation_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class AppoinmentBooking extends StatelessWidget {
  AppoinmentBooking({Key? key}) : super(key: key);
  final BottomNavbarIndexController _bottomNavbarIndexController =
      Get.find<BottomNavbarIndexController>();

  final List<String> timeSlots = [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
  ];

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Appointment Booking',
      ),
      body: content(),
      bottomNavigationBar: CommonBottomNavigationBar(
        currentIndex: _bottomNavbarIndexController.currentIndex.value,
        onTap: (index) {
          _bottomNavbarIndexController.currentIndex.value = index;
        },
      ),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: TableCalendar(
              rowHeight: 43,
              headerStyle: HeaderStyle(formatButtonVisible: false),
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
              lastDay: DateTime.utc(2030, 3, 14),
            ),
          ),
          Divider(
            height: 20,
            color: Colors.black,
            thickness: 2, // Adjust the thickness of the line
          ),

          SizedBox(height: 20), // Add some spacing
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 20, // Horizontal space between boxes
            runSpacing: 20, // Vertical space between rows of boxes
            children: timeSlots.map((timeSlot) {
              return Container(
                width: 90,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  timeSlot,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.paymentScreen);
            },
            child: Text('Payment'),
          ),
        ],
      ),
    );
  }
}
