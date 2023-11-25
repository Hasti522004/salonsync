import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/screen_controller/payment_controller.dart';


class PaymentScreen extends StatelessWidget {
  final PaymentController _paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text("Payment Screen"),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: TextField(
                controller: _paymentController.amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Enter Amount"),
              ),
            ),
            CupertinoButton(
              color: Colors.grey,
              child: Text("Pay Amount"),
              onPressed: _paymentController.makePayment,
            )
          ],
        ),
      ),
    );
  }
}
