import 'package:get/get.dart';
import 'package:salonsync/services/firebase_operations.dart';

class SalonListController extends GetxController {
  var salonList = <Map<String, dynamic>>[].obs;

  void updateSalonList() async {
    // Fetch your salons from Firebase or any other source.
    var fetchedSalons = await FirebaseOperation().fetchSalons();
    salonList.assignAll(fetchedSalons);
  }
}