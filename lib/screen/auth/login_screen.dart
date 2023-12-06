import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:salonsync/controller/auth/login_conroller.dart';
import 'package:salonsync/screen/auth/verification_screen.dart';
import 'package:salonsync/screen/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animation/animation_login.json'),
                  SizedBox(height: 25),
                  Text(
                    "Phone Verification",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "We need to register your phone without getting started!",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      _loginController.phone.value = number.phoneNumber!;
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    initialValue: PhoneNumber(isoCode: 'IN'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid phone number';
                      }
                      String sanitizedPhoneNumber =
                          value.replaceAll(RegExp(r'\D'), '');
                      if (sanitizedPhoneNumber.length != 10) {
                        return 'Phone number must have exactly 10 digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 78, 150, 150),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String fullPhoneNumber = _loginController.phone.value;
                          print(
                              "Phone number for authentication: $fullPhoneNumber");

                          // Check if the user is already authenticated
                          User? currentUser = FirebaseAuth.instance.currentUser;
                          if (currentUser != null) {
                            // User is already signed in, navigate to HomeScreen
                            print(currentUser);
                            Get.to(HomeScreen());
                          } else {
                            // User not found, proceed with sending the verification code
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: fullPhoneNumber,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {
                                print("Verification failed: ${e.message}");
                              },
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                Get.to(VerificationScreen(verificationId));
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          }
                        }
                      },
                      child: Text(
                        "Verify Phone Number",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
