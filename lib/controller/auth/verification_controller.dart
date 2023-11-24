import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salonsync/screen/auth/profile_screen.dart';

class VerificationController extends GetxController {
  // Observable for the entered OTP
  var otp = "".obs;

  // Function to handle verification logic
  Future<void> verifyOTP(String verificationId) async {
    try {
      // Implement your verification logic here using the entered OTP (otp.value)
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp.value,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // If verification is successful, navigate to the profile screen
      Get.offAll(ProfileScreen()); // Assuming you have a ProfileScreen defined
    } catch (e) {
      print("Error during OTP verification: $e");
      // Handle the error as needed
    }
  }
}
