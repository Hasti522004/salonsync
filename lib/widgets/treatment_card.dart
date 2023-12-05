import 'package:flutter/material.dart';
import 'package:salonsync/model/treatment_card_model.dart';

Widget TreatmentbuildCardWidget({
  required TreatmentCard tcard,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: Color.fromARGB(255, 231, 226, 226),
      child: Column(
        children: [
          Container(
            // Set the background color to gray below the image
            color: Color.fromARGB(18, 66, 31, 136),
            child: Image.network(
              tcard.image,
              height: 150.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tcard.treatmentName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('price:${tcard.price}'),
                Text('Duration: ${tcard.duration}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
