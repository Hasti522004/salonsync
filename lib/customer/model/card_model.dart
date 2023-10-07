import 'package:flutter/material.dart';

class CardModel {
  final String image;
  final String salonName;
  final String address;
  final double rating;
  final int likeCount;

  CardModel({
    required this.image,
    required this.salonName,
    required this.address,
    required this.rating,
    required this.likeCount,
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
                    salonName,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'RobotoMono',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    address,
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
                        '$likeCount',
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
    );
  }
}
