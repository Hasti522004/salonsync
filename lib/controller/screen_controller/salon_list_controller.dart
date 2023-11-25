import 'package:get/get.dart';
import 'package:salonsync/services/firebase_operations.dart';

class SalonListController extends GetxController {
  var salonList = <Map<String, dynamic>>[].obs;
  final RxString selectedSalonId = ''.obs; // Add this line

  void updateSalonList() async {
    // Fetch your salons from Firebase or any other source.
    var fetchedSalons = await FirebaseOperation().fetchSalons();
    salonList.assignAll(fetchedSalons);
  }

  void updateSelectedSalonId(String salonId) {
    selectedSalonId.value = salonId;
    update(['selectedSalonId']);
  }
}