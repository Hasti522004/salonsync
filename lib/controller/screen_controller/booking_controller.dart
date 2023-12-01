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
    DateTime currentTime = DateTime.now();

    int startHour = currentTime.hour;
    int startMinute = currentTime.minute;
    int endHour = 20;

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

  // New methods for month navigation
  // void nextMonth() {
  //   selectedDate.value = DateTime(selectedDate.value.year,
  //       selectedDate.value.month + 1, selectedDate.value.day);
  // }

  // void previousMonth() {
  //   selectedDate.value = DateTime(selectedDate.value.year,
  //       selectedDate.value.month - 1, selectedDate.value.day);
  // }

  // Additional methods from HomeController
  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
      helpText: 'Select Date',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'Select Date',
      fieldHintText: 'Month/Date/Year',
      selectableDayPredicate: disableDate,
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  bool disableDate(DateTime day) {
    // Disable all past dates
    return day.isAfter(DateTime.now().subtract(Duration(days: 1)));
  }
}
