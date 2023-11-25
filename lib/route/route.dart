// routes.dart

import 'package:get/get.dart';
import 'package:salonsync/admin/add_salon_screen.dart';
import 'package:salonsync/admin/add_treatment_screen.dart';
import 'package:salonsync/binding/app_binding.dart';
import 'package:salonsync/screen/auth/login_screen.dart';
import 'package:salonsync/screen/auth/profile_screen.dart';
import 'package:salonsync/screen/booking/booking_screen.dart';
import 'package:salonsync/screen/home/home_screen.dart';
import 'package:salonsync/screen/home/main_profile_screen.dart';
import 'package:salonsync/screen/home/treatment_screen.dart';
import 'package:salonsync/screen/payment/payment_screen.dart';

class AppRoutes {
  static const homeScreen = '/home_screen';
  static const treatmentScreen = '/treatment_screen';
  static const appointmentBooking = '/appointment_booking';
  static const paymentScreen = '/payment_screen';
  static const profilePage = '/profile_screen';
  static const mainprofilePage = '/main_profile_screen';
  static const addSalonPage = '/add_Salon_screen';
  static const addTreatmentPage = '/add_Treatment_Page';

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
        page: () => AppointmentBookingScreen()),
    GetPage(
      name: paymentScreen,
      page: () => PaymentScreen(),
    ),
    GetPage(
      name: mainprofilePage,
      page: () => MainProfilePage(),
    ),
    GetPage(
      name: addSalonPage,
      page: () => AddSalonScreen(),
      binding: AppBindings(),
    ),
    GetPage(
      name: addTreatmentPage,
      page: () => AddTreatmentScreen(),
      binding: AppBindings(),
    ),
    GetPage(
      name: '/profilePage',
      page: () => ProfileScreen(),
    ),

    GetPage(
      name: '/login',
      page: () => LoginScreen(),
    ),

    // Add more pages as needed
  ];
}
