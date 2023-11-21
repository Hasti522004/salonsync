import 'package:get/get.dart';
import 'package:salonsync/controller/auth/login_conroller.dart';
import 'package:salonsync/controller/auth/verification_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => VerifyController());
    // Add other controllers as needed
  }
}
