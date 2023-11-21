import 'package:get/get.dart';
import 'package:salonsync/controller/screen_controller/bottom_navbar_index_controller.dart';
import 'package:salonsync/controller/auth/login_conroller.dart';
import 'package:salonsync/controller/auth/verification_controller.dart';
import 'package:salonsync/controller/screen_controller/profile_controller.dart';
import 'package:salonsync/controller/screen_controller/treatment_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => VerifyController());
    Get.lazyPut(() => BottomNavbarIndexController());
    Get.lazyPut(() => TreatmentController());
    Get.lazyPut(() => EditProfileController());
    
    // Add other controllers as needed
  }
}
