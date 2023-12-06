import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salonsync/controller/screen_controller/salon_list_controller.dart';
import 'package:salonsync/controller/theme_controller.dart';
import 'package:salonsync/model/salon_card_model.dart';
import 'package:salonsync/screen/home/treatment_screen.dart';
import 'package:salonsync/services/firebase_operations.dart';
import 'package:salonsync/widgets/common_app_bar.dart';
import 'package:salonsync/widgets/salon_card.dart';
import 'package:salonsync/widgets/sidebar_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseOperation _firebaseFunctions = FirebaseOperation();
  final _SalonListController = Get.put(SalonListController());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return Scaffold(
          appBar: CommonAppBar(
            title: "Salon-List",
            onSearchIconPressed: () {
              _SalonListController.toggleSearchBar();
            },
          ),
          endDrawer: CommonDrawer(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => Visibility(
                    visible: _SalonListController.showSearchBar.value,
                    child: TextField(
                      controller: _searchController,
                      onChanged: (query) {
                        _liveSearch(query);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search salon',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _firebaseFunctions.fetchSalons(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      List<Map<String, dynamic>> allSalons = snapshot.data!;
                      List<Map<String, dynamic>> filteredSalons =
                          _SalonListController.salonList;

                      return ListView(
                        children: _buildCardWidgets(
                          _searchController.text.isNotEmpty
                              ? filteredSalons
                              : allSalons,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildCardWidgets(List<Map<String, dynamic>> salons) {
    List<Widget> cardWidgets = [];

    for (var salon in salons) {
      SalonCard card = SalonCard(
        image: salon['imageUrl'],
        salonName: salon['salonName'] ?? 'Unknown Salon',
        address: salon['address'] ?? 'Unknown Address',
        rating: (salon['rating'] ?? 0).toDouble(),
        likeCount: salon['likeCount'] ?? 0,
        onTap: () {
          Get.to(
            () => TreatmentScreen(),
            arguments: {'salonName': salon['salonName']},
          );
        },
      );
      cardWidgets.add(SalonbuildCardWidget(context, card, () {
        Get.to(() => TreatmentScreen(),
            arguments: {'salonName': salon['salonName']});

        _SalonListController.updateSelectedSalonId(salon['id']);
        print("Salon Id: ${_SalonListController.selectedSalonId}");
        print('Salon card tapped!');
      }));
    }

    return cardWidgets;
  }

  void _liveSearch(String query) async {
    List<Map<String, dynamic>> salons = await _searchSalonByName(query);
    _SalonListController.salonList.assignAll(salons);
    setState(() {});
  }

  Future<List<Map<String, dynamic>>> _searchSalonByName(String query) async {
    List<Map<String, dynamic>> salonList =
        await _firebaseFunctions.fetchSalons();

    return salonList
        .where((salon) => (salon['salonName'] as String)
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }
}
