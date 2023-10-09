import 'package:flutter/material.dart';

class TreatmentCard {
  final String image;
  final String treatmentName;
  final String details;
  final double price;

  TreatmentCard({
    required this.image,
    required this.treatmentName,
    required this.details,
    required this.price,
  });

  Widget buildCardWidget(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Card(
        color: Color.fromARGB(57, 123, 120, 121),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 175,
                width: screenWidth * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    treatmentName,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    details,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('$price' ),
                  Icon(
                    Icons.favorite_border,
                    color: Color.fromARGB(255, 12, 8, 8),
                    size: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
