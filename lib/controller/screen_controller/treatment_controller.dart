import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/model/treatment_card_model.dart';
import 'package:salonsync/widgets/treatment_card.dart';

class TreatmentController extends GetxController {
  final RxList<Widget> cardList = <Widget>[].obs;

  @override
  void onInit() {
    super.onInit();
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
                  child: TreatmentbuildCardWidget(
                    TreatmentCard(
                      image: image,
                      treatmentName: treatmentName1,
                      price: price1,
                    ),
                  ),
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
                  child: TreatmentbuildCardWidget(
                    TreatmentCard(
                      image: image,
                      treatmentName: treatmentName1,
                      price: price1,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TreatmentbuildCardWidget(
                    TreatmentCard(
                      image: image,
                      treatmentName: treatmentName2,
                      price: price2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
  }
}
