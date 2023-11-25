import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  late var _razorpay;
  var amountController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  void makePayment() {
    var options = {
      'key': "your_api_key_here",
      'amount': (int.parse(amountController.text) * 100).toString(),
      'name': 'Your App Name',
      'description': 'Payment Description',
      'timeout': 300, // in seconds
      'prefill': {
        'contact': 'user_phone_number',
        'email': 'user_email@example.com',
      }
    };
    _razorpay.open(options);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}