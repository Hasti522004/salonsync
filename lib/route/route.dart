// routes.dart

import 'package:get/get.dart';
import 'package:salonsync/screen/auth/login_screen.dart';
import 'package:salonsync/screen/auth/verification_screen.dart';
import 'package:salonsync/screen/booking/booking_screen.dart';
import 'package:salonsync/screen/home/home_screen.dart';
import 'package:salonsync/screen/home/profile_screen.dart';
import 'package:salonsync/screen/home/treatment_screen.dart';
import 'package:salonsync/screen/payment/payment_screen.dart';

class AppRoutes {
  static const homeScreen = '/home_screen';
  static const treatmentScreen = '/treatment_screen';
  static const appointmentBooking = '/appointment_booking';
  static const  paymentScreen = '/payment_screen';
  static const  profilePage = '/profile_screen';

  static final routes = [
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: treatmentScreen,
      page: () => TreatmentScreen(),
    ),
    GetPage(
      name: appointmentBooking,
      page: () => AppoinmentBooking(),
    ),
    GetPage(
      name: paymentScreen,
      page: () => PaymentScreen(),
    ),
    GetPage(
      name: profilePage,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
    ),
    
    GetPage(
      name: '/PhoneNumberVerification',
      page: () => MyVerify(),
    ),
    
    // Add more pages as needed
  ];
}
