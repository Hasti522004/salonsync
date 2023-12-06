import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseOperation {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addUserData({
    required String name,
    required String photoUrl,
    required String address,
    required String phoneNumber,
  }) async {
    try {
      await _firestore.collection('users').add({
        'name': name,
        'photoUrl': photoUrl,
       
        'phoneNumber': phoneNumber,
        'isAdmin': false, // Add the 'isAdmin' field with a default value
        'isSalon': false,
        'address1': address,
        'address2': null,
      });
      print('User data added successfully.');
    } catch (error) {
      print('Error adding user data: $error');
    }
  }

  Future<String?> getUserIdByPhoneNumber(String phoneNumber) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming that there is only one user with a given phone number
        return querySnapshot.docs.first.id;
      } else {
        print('User not found with phone number: $phoneNumber');
        return null;
      }
    } catch (e) {
      print('Error getting user ID: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(userId).get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        print('User not found with ID: $userId');
        return {};
      }
    } catch (e) {
      print('Error getting user data: $e');
      return {};
    }
  }

  Future<void> updateUserProfile(String userId,
      {String? name, String? address1, String? address2}) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'name': name,
        'address1': address1,
        'address2': address2,
      });

      print('User profile updated successfully.');
    } catch (error) {
      print('Error updating user profile: $error');
      // You can throw the error here if needed
    }
  }

  Future<void> addSalon(String salonName, String address, int rating,
      int likeCount, String imageUrl) async {
    try {
      await _firestore.collection('salons').add({
        'salonName': salonName,
        'address': address,
        'rating': rating,
        'likeCount': likeCount,
        'imageUrl': imageUrl,
      });
      print('Salon added successfully.');
    } catch (e) {
      print("Error adding salon: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchSalons() async {
    List<Map<String, dynamic>> salonList = [];
    try {
      QuerySnapshot snapshot = await _firestore.collection('salons').get();

      snapshot.docs.forEach((doc) {
        Map<String, dynamic> salonData = doc.data() as Map<String, dynamic>;
        salonData['id'] = doc.id; // Add the document ID to the salon data
        salonList.add(salonData);
      });
    } catch (e) {
      print("Error fetching salons: $e");
    }
    return salonList;
  }

  Future<List<Map<String, dynamic>>> featchslots() async {
    List<Map<String, dynamic>> slotlist = [];
    try {
      QuerySnapshot snapshot = await _firestore.collection('appointment').get();

      snapshot.docs.forEach((doc) {
        Map<String, dynamic> slotData = doc.data() as Map<String, dynamic>;
        slotData['id'] = doc.id; // Add the document ID to the salon data
        slotlist.add(slotData);
      });
    } catch (e) {
      print("Error fetching salons: $e");
    }
    return slotlist;
  }

  Future<void> addTreatment(String treatmentName, double price, String duration,
      String imageUrl) async {
    try {
      await _firestore.collection('treatments').add({
        'treatmentName': treatmentName,
        'price': price,
        'duration': duration,
        'imageUrl': imageUrl,
      });
      print('Treatment added successfully.');
    } catch (e) {
      print("Error adding treatment: $e");
    }
  }

  Future<void> addAppointmentBooking({
    required String userId,
    required String selectedDate,
    required String selectedTimeSlot,
    required String selectedTreatmentId,
    required String selectedSalonId,
  }) async {
    try {
      await _firestore.collection('appointment').add({
        'userId': userId,
        'selectedDate': selectedDate,
        'selectedTimeSlot': selectedTimeSlot,
        'selectedTreatmentId': selectedTreatmentId,
        'selectedSalonId': selectedSalonId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('Appointment booking added successfully.');
    } catch (e) {
      print("Error adding appointment booking: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchTreatments() async {
    List<Map<String, dynamic>> treatmentList = [];
    try {
      QuerySnapshot snapshot = await _firestore.collection('treatments').get();

      snapshot.docs.forEach((doc) {
        Map<String, dynamic> treatmentData = doc.data() as Map<String, dynamic>;
        treatmentData['id'] = doc.id;
        treatmentList.add(treatmentData);
      });
    } catch (e) {
      print("Error fetching treatments: $e");
    }
    return treatmentList;
  }

  Future<String?> uploadImage(File file, String imageType) async {
    try {
      String folderName;

      // Choose folder based on imageType
      switch (imageType) {
        case 'user':
          folderName = 'user_images';
          break;
        case 'salon':
          folderName = 'salon_images';
          break;
        case 'treatment':
          folderName = 'treatment_images';
          break;
        default:
          folderName =
              'other_images'; // You can choose a default folder or handle this case as needed
      }

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference =
          FirebaseStorage.instance.ref('$folderName/$fileName');
      await reference.putFile(file);

      String downloadUrl = await reference.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> deleteUserData(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
    } catch (e) {
      print('Error deleting user data: $e');
      // Handle the error (show a message or log it)
    }
  }

  Future<bool> fetchIsAdmin(String userId) async {
    try {
      print("userId :${userId}");
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();

      // Check if the snapshot exists and contains data
      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic>? userData =
            snapshot.data() as Map<String, dynamic>?;

        // Check if userData is not null
        if (userData != null && userData['isAdmin'] == true) {
          print("UserData : ${userData['isAdmin']}");
          return userData['isAdmin'] as bool;
        }
      }

      return false; // Default to false if 'isAdmin' is not present or is not a boolean.
    } catch (e) {
      print('Error fetching isAdmin: $e');
      return false;
    }
  }
}
