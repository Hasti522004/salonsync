import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentBookingController extends GetxController {
  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxString selectedTimeSlot = ''.obs;

  final List<String> timeSlots = generateTimeSlots();

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  void updateSelectedTimeSlot(String timeSlot) {
    selectedTimeSlot.value = timeSlot;
    update(['timeSlot']);
  }

  bool isSelectedTimeSlot(String timeSlot) {
    return selectedTimeSlot.value == timeSlot;
  }

  static List<String> generateTimeSlots() {
    List<String> timeSlots = [];
    int startHour = 8; // Start from 8 AM
    int startMinute = 0;
    int endHour = 20; // End at 8 PM

    while (startHour < endHour) {
      String formattedTime =
          '${startHour % 12 == 0 ? 12 : startHour % 12}:${startMinute.toString().padLeft(2, '0')} ${startHour < 12 ? 'AM' : 'PM'}';
      timeSlots.add(formattedTime);

      startMinute += 30;
      if (startMinute >= 60) {
        startHour++;
        startMinute = 0;
      }
    }

    return timeSlots;
  }

  // Additional methods from HomeController
  // Additional methods from HomeController
  chooseDate() async {
    DateTime currentDate = DateTime.now();
    DateTime firstAllowedDate = currentDate;
    DateTime lastAllowedDate =
        currentDate.add(Duration(days: 60)); // Two months later

    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: firstAllowedDate,
      lastDate: lastAllowedDate,
      helpText: 'Select Date',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter a valid date',
      errorInvalidText: 'Enter a valid date range',
      fieldLabelText: 'Select Date',
      fieldHintText: 'Month/Date/Year',
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }
}
