import 'package:flutter/material.dart';
import 'package:salonsync/customer/screen/payment_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class AppoinmentBooking extends StatefulWidget {
  AppoinmentBooking({super.key});

  @override
  State<AppoinmentBooking> createState() => _AppoinmentBookingState();
}

class _AppoinmentBookingState extends State<AppoinmentBooking> {
  final List<String> timeSlots = [
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
  ];

  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Booking'),
      ),
      body: content(),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: TableCalendar(
              rowHeight: 43,
              headerStyle: HeaderStyle(formatButtonVisible: false),
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ),
              lastDay: DateTime.utc(2030, 3, 14),
            ),
          ),
          Divider(
            height: 20,
            color: Colors.black,
            thickness: 2, // Adjust the thickness of the line
          ),

          SizedBox(height: 20), // Add some spacing
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 20, // Horizontal space between boxes
            runSpacing: 20, // Vertical space between rows of boxes
            children: timeSlots.map((timeSlot) {
              return Container(
                width: 90,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: Colors.grey),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  timeSlot,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PaymentHistory()),
              );
            },
            child: Text('Payment'),
          ),
        ],
      ),
    );
  }
}
