// appointment_booking.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salonsync/controller/screen_controller/booking_controller.dart';
import 'package:salonsync/controller/screen_controller/salon_list_controller.dart';
import 'package:salonsync/controller/screen_controller/treatment_controller.dart';
import 'package:salonsync/controller/userid_record.dart';
import 'package:salonsync/screen/payment/payment_screen.dart';
import 'package:salonsync/services/firebase_operations.dart';

class AppointmentBookingScreen extends StatelessWidget {
  final AppointmentBookingController _controller =
      Get.put(AppointmentBookingController());
  final _treatmentcontroller = Get.find<TreatmentController>();
  final _saloncontroller = Get.find<SalonListController>();
  final FirebaseOperation _firebaseOperation = FirebaseOperation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appointment Booking')),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Date:'),
            Obx(
              () => Text(
                DateFormat("dd-MM-yyyy")
                    .format(_controller.selectedDate.value)
                    .toString(),
                style: TextStyle(fontSize: 25),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.chooseDate();
              },
              child: Text('Select Date'),
            ),
            Divider(),
            Text('Select Time Slot:'),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _controller.timeSlots.length,
                itemBuilder: (context, index) {
                  String timeSlot = _controller.timeSlots[index];
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
                          height: 10,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.green : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            timeSlot,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : null,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                print('User ID: ${UserManager.userId}');
                print('Selected Date: ${_controller.selectedDate.value}');
                print(
                    'Selected Time Slot: ${_controller.selectedTimeSlot.value}');
                print(
                    'Selected Treatment ID: ${_treatmentcontroller.selectedTreatmentId}');
                print('Selected Salon ID: ${_saloncontroller.selectedSalonId}');

                await _firebaseOperation.addAppointmentBooking(
                  userId: "${UserManager.userId}",
                  selectedDate: "${_controller.selectedDate.value}",
                  selectedTimeSlot: "${_controller.selectedTimeSlot.value}",
                  selectedTreatmentId:
                      "${_treatmentcontroller.selectedTreatmentId}",
                  selectedSalonId: "${_saloncontroller.selectedSalonId}",
                );
                Get.to(PaymentScreen());
              },
              child: Text('Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
