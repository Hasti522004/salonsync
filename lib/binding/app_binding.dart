import 'package:get/get.dart';
import 'package:salonsync/controller/admin_controller/add_salon_controller.dart';
import 'package:salonsync/controller/admin_controller/add_treatment_controller.dart';
import 'package:salonsync/controller/auth/login_conroller.dart';
import 'package:salonsync/controller/auth/profile_controller.dart';
import 'package:salonsync/controller/auth/verification_controller.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/controller/screen_controller/profile_controller.dart';
import 'package:salonsync/controller/screen_controller/salon_list_controller.dart';
import 'package:salonsync/controller/screen_controller/treatment_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => VerificationController());
    Get.put(BottomNavbarIndexController());
    Get.lazyPut(() => TreatmentController());
    Get.lazyPut(() => EditProfileController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => AddSalonController());
    Get.lazyPut(() => SalonListController());
    Get.lazyPut(() => AddTreatmentController());

    // Add other controllers as needed
  }
}
