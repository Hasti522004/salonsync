import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/model/treatment_card_model.dart';
import 'package:salonsync/services/firebase_operations.dart';
import 'package:salonsync/widgets/treatment_card.dart';

class TreatmentController extends GetxController {
  final RxList<Widget> cardList = <Widget>[].obs;

  @override
  void onInit() {
    super.onInit();
    _generateCards();
  }

  void _generateCards() async {
    try {
      // Fetch treatments from Firebase
      List<Map<String, dynamic>> treatments =
          await FirebaseOperation().fetchTreatments();

      // Iterate through treatments and generate cards
      for (int i = 0; i < treatments.length; i += 2) {
        String image1 = treatments[i]['imageUrl'];
        String treatmentName1 = treatments[i]['treatmentName'];
        double price1 = treatments[i]['price'];
        String duration1 = treatments[i]['duration'];

        String image2 =
            (i + 1 < treatments.length) ? treatments[i + 1]['imageUrl'] : '';
        String treatmentName2 = (i + 1 < treatments.length)
            ? treatments[i + 1]['treatmentName']
            : '';
        double price2 =
            (i + 1 < treatments.length) ? treatments[i + 1]['price'] : 0;
        String duration2 =
            (i + 1 < treatments.length) ? treatments[i + 1]['duration'] : '';

        cardList.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TreatmentbuildCardWidget(
                    TreatmentCard(
                      image: image1,
                      treatmentName: treatmentName1,
                      price: price1,
                      duration: duration1,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TreatmentbuildCardWidget(
                    TreatmentCard(
                      image: image2,
                      treatmentName: treatmentName2,
                      price: price2,
                      duration: duration2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    } catch (e) {
      print('Error fetching and generating treatment cards: $e');
    }
  }
}
