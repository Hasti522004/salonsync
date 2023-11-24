import 'package:flutter/material.dart';
import 'package:salonsync/model/salon_card_model.dart';

Widget SalonbuildCardWidget(
    BuildContext context, SalonCard salonCard, VoidCallback onTap) {
  double screenWidth = MediaQuery.of(context).size.width;

  return GestureDetector(
    onTap: onTap, // Handle the tap event
    child: Container(
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
                    image: NetworkImage(salonCard.image),
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
                    salonCard.salonName,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    salonCard.address,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 2,
                      ),
                      Icon(
                        Icons.star_half,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star_border,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.favorite_border,
                        color: Color.fromARGB(255, 12, 8, 8),
                        size: 20,
                      ),
                      Text(
                        '${salonCard.likeCount}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
