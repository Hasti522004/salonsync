import 'package:flutter/material.dart';
import 'package:salonsync/model/treatment_card_model.dart';

Widget TreatmentbuildCardWidget(TreatmentCard tcard) {
  return Card(
    child: Column(
      children: [
        Image.network(
          tcard.image,
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
                tcard.treatmentName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('\$$tcard.price'),
              Text('Duration: ${tcard.duration}'),
            ],
          ),
        ),
      ],
    ),
  );
}
