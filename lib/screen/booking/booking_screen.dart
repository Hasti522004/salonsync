// appointment_booking.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salonsync/controller/screen_controller/booking_controller.dart';
import 'package:salonsync/controller/screen_controller/payment_controller.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/sidebar_widget.dart';
// ... (previous imports)

class AppointmentBookingScreen extends StatelessWidget {
  final AppointmentBookingController _controller =
      Get.put(AppointmentBookingController());
  final PaymentController _paymentController = Get.put(PaymentController());

  var amount = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Booking"),
      endDrawer: CommonDrawer(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _controller.chooseDate();
                },
                child: Text('Select Date'),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Selected Date: ',
                    style:
                        TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                Obx(
                  () => Text(
                    DateFormat("dd-MM-yyyy")
                        .format(_controller.selectedDate.value)
                        .toString(),
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 24, 24, 24)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Select Time Slot:',
              style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height *
                  0.5, // Adjust the height as needed
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: (_controller.timeSlots.length / 3).ceil(),
                itemBuilder: (context, rowIndex) {
                  int startIndex = rowIndex * 3;
                  int endIndex = (rowIndex + 1) * 3;
                  if (endIndex > _controller.timeSlots.length) {
                    endIndex = _controller.timeSlots.length;
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(endIndex - startIndex, (index) {
                      String timeSlot =
                          _controller.timeSlots[startIndex + index];
                      return Obx(
                        () {
                          bool isSelected =
                              _controller.isSelectedTimeSlot(timeSlot);
                          return GestureDetector(
                            onTap: () {
                              _controller.updateSelectedTimeSlot(timeSlot);
                              print('Selected Time Slot: $timeSlot');
                            },
                            child: Container(
                              width: 90,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Color.fromARGB(255, 125, 179, 167)
                                    : null,
                                border: Border.all(
                                  color: Color.fromARGB(
                                      255, 147, 144, 144), // Border color
                                  width: 2, // Border width
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  timeSlot,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Color.fromARGB(255, 116, 146, 98),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Spacer(),
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add logic to display payment amount
                        print('Payment Amount: Add your logic here');
                      },
                      child: Text('Amount: ₹${amount}'),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () async {
                        _paymentController.amountController.text =
                            amount.toString(); // Set the amount
                        _paymentController.makePayment();
                      },
                      child: Text('Payment'),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
