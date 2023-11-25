import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/model/treatment_card_model.dart';
import 'package:salonsync/screen/booking/booking_screen.dart';
import 'package:salonsync/services/firebase_operations.dart';
import 'package:salonsync/widgets/treatment_card.dart';

class TreatmentController extends GetxController {
  final RxList<Widget> cardList = <Widget>[].obs;
  final RxString selectedTreatmentId = ''.obs; // Add this line

  void updateSelectedTreatmentId(String treatmentId) {
    selectedTreatmentId.value = treatmentId;
    update(['selectedTreatmentId']);
  }

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
        String treatmentId = treatments[i]['id'];

        String image2 =
            (i + 1 < treatments.length) ? treatments[i + 1]['imageUrl'] : '';
        String treatmentName2 = (i + 1 < treatments.length)
            ? treatments[i + 1]['treatmentName']
            : '';
        double price2 =
            (i + 1 < treatments.length) ? treatments[i + 1]['price'] : 0;
        String duration2 =
            (i + 1 < treatments.length) ? treatments[i + 1]['duration'] : '';
        String img = treatments[i]['imageUrl'];
        String treatmentId2 = treatments[i + 1]['id'];
// ... (similar checks for other variables)

        if (img.isNotEmpty) {
          cardList.add(
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TreatmentbuildCardWidget(
                      tcard: TreatmentCard(
                        image: image1,
                        treatmentName: treatmentName1,
                        price: price1,
                        duration: duration1,
                      ),
                      onTap: () {
                        updateSelectedTreatmentId(treatmentId);
                        updateSelectedTreatmentId(treatmentId);
                        if (treatmentId.isNotEmpty) {
                          print("Treatment ID: $treatmentId");
                        } else {
                          print("Treatment ID is empty or null.");
                        }
                        navigateToBookingScreen(
                          treatmentName1,
                          price1,
                          duration1,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TreatmentbuildCardWidget(
                      tcard: TreatmentCard(
                        image: image2,
                        treatmentName: treatmentName2,
                        price: price2,
                        duration: duration2,
                      ),
                      onTap: () {
                        updateSelectedTreatmentId(treatmentId2);
                        print("Treatment ID : ${treatmentId2}");
                        navigateToBookingScreen(
                          treatmentName2,
                          price2,
                          duration2,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }
    } catch (e) {
      print('Error fetching and generating treatment cards: $e');
    }
  }

  void navigateToBookingScreen(
      String treatmentName, double price, String duration) {
    Get.to(() => AppointmentBookingScreen());
  }
}
