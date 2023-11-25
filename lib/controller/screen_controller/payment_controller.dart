import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:salonsync/route/route.dart';

class PaymentController extends GetxController {
  late Razorpay _razorpay;
  var amountController = TextEditingController();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Initialize local notifications
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment Done");

    // Show success notification
    _showNotification("Payment Successful", "Thank you for your payment!");
    Get.toNamed(AppRoutes.homeScreen);
    // Add logic to send notifications to user and salon here
    // You can use Firebase Cloud Messaging (FCM) for this purpose.
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment Fail");

    // Show failure notification
    _showNotification(
        "Payment Failed", "Oops! Something went wrong with your payment.");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  void makePayment() {
    var options = {
      'key': "rzp_test_RlrXk4ux4O9Gr9",
      'amount': (int.parse(amountController.text) * 100).toString(),
      'name': 'SalonSync',
      'description': 'Payment Description',
      'timeout': 300, // in seconds
      'prefill': {
        'contact': '+919909256723',
        'email': 'hasti.hajipara@gmail.com',
      }
    };
    _razorpay.open(options);
  }

  void _showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
