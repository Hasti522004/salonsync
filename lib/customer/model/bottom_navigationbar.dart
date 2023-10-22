import 'package:flutter/material.dart';
import 'package:salonsync/customer/screen/booking_screen.dart';
import 'package:salonsync/customer/screen/home_screen.dart';
import 'package:salonsync/customer/screen/treatment_screen.dart';

class CommonBottomNavigationScreen extends StatefulWidget {
  const CommonBottomNavigationScreen({Key? key}) : super(key: key);

  @override
  _CommonBottomNavigationScreenState createState() =>
      _CommonBottomNavigationScreenState();
}

class _CommonBottomNavigationScreenState
    extends State<CommonBottomNavigationScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeScreen(); // Create a HomeScreen widget.
      case 1:
        return TreatmentScreen(); // Create a SettingsScreen widget.
      case 2:
        return AppoinmentBooking(); // Create a ProfileScreen widget.
      default:
        return HomeScreen();
    }
  }
}
