import 'package:flutter/material.dart';
import 'package:salonsync/customer/model/treatment_card.dart';

class TreatmentScreen extends StatefulWidget {
  const TreatmentScreen({Key? key});

  @override
  State<TreatmentScreen> createState() => _TreatmentScreenState();
}

class _TreatmentScreenState extends State<TreatmentScreen> {
  List<Widget> cardList = [];

  @override
  void initState() {
    super.initState();
    _generateCards();
  }

  void _generateCards() {
    int numCards = 7;

    for (int i = 1; i <= numCards; i += 2) {
      String image = 'assets/images/treatment-2.jpeg';
      String treatmentName1 = 'Treatment $i';
      double price1 = 400;

      String treatmentName2 = 'Treatment ${i + 1}';
      double price2 = 500;

      if (numCards % 2 != 0 && i == numCards) {
        cardList.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TreatmentCard(
                    image: image,
                    treatmentName: treatmentName1,
                    price: price1,
                  ).buildCardWidget(),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Card(),
                ),
              ],
            ),
          ),
        );
      } else {
        cardList.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TreatmentCard(
                    image: image,
                    treatmentName: treatmentName1,
                    price: price1,
                  ).buildCardWidget(),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TreatmentCard(
                    image: image,
                    treatmentName: treatmentName2,
                    price: price2,
                  ).buildCardWidget(),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Treatment Screen'),
        ),
        body: ListView(
          children: cardList,
        ),
      ),
    );
  }
}
