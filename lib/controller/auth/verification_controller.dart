// lib/controller/verify_controller.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:salonsync/screen/home/home_screen.dart';

class VerifyController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = "".obs;

  Future<void> signInWithPhoneNumber(
      String verificationId, String value) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code.value, // Access the value property of the observable
      );
      await auth.signInWithCredential(credential);
      // Use Get.offAll for navigation without the ability to go back
      Get.offAll(() => HomeScreen());
    } catch (e) {
      print("Verification ID: $verificationId");
      print("Entered OTP: $code");
      print("Wrong OTP");
    }
  }
}
