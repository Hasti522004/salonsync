// appointment_booking_model.dart

class AppointmentBookingModel {
  final DateTime selectedDate;
  final String selectedTimeSlot;
  final String treatmentName;
  final double price;
  final String duration;

  AppointmentBookingModel({
    required this.selectedDate,
    required this.selectedTimeSlot,
    required this.treatmentName,
    required this.price,
    required this.duration,
  });
}
