import 'package:flutter/material.dart';

class TreatmentCard {
  final String image;
  final String treatmentName;
  final double price;

  TreatmentCard({
    required this.image,
    required this.treatmentName,
    required this.price,
  });

  Widget buildCardWidget() {
    return Card(
      child: Column(
        children: [
          Image.asset(
            image,
            height: 150.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  treatmentName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('\$$price'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
