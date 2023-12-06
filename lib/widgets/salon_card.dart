import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Import Google Maps package
import 'package:salonsync/controller/theme_controller.dart';
import 'package:salonsync/model/salon_card_model.dart';
import 'package:salonsync/utils/colors.dart';

Widget SalonbuildCardWidget(
  BuildContext context,
  SalonCard salonCard,
  VoidCallback onTap,
) {
  double screenWidth = MediaQuery.of(context).size.width;

  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      height: MediaQuery.of(context).size.height * 0.25,
      width: 100,
      child: GetBuilder<ThemeController>(
        builder: (themeController) {
          return Card(
            color: themeController.isThemeGreen.value
                ? AppColors.themeGreen
                : Color.fromARGB(255, 7, 7, 7),
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
                Expanded(
                  child: Padding(
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
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          salonCard.address,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          // Optionally, you can limit the number of lines:
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                            // Icon(
                            //   Icons.favorite_border,
                            //   color: Color.fromARGB(255, 219, 27, 27),
                            //   size: 20,
                            // ),
                            GestureDetector(
                              onTap: () {
                                _showMap(context, salonCard); // Show the map
                              },
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

void _showMap(BuildContext context, SalonCard salonCard) async {
  try {
    List<Location> locations = await locationFromAddress(salonCard.address);
    Location salonLocation = locations.first;
    print('Geocoding Result: $salonLocation');
    Get.defaultDialog(
      title: 'Salon Location',
      content: Container(
        height: 300,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(salonLocation.latitude, salonLocation.longitude),
            zoom: 15,
          ),
          markers: {
            Marker(
              markerId: MarkerId('salonMarker'),
              position: LatLng(salonLocation.latitude, salonLocation.longitude),
              infoWindow: InfoWindow(
                title: salonCard.salonName,
                snippet: salonCard.address,
              ),
            ),
          },
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Close'),
      ),
    );
  } catch (e) {
    print('Error: $e');
    // Handle errors such as invalid address or network issues
  }
}
