import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseOperation {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addUserData({
    required String name,
    required String photoUrl,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      await _firestore.collection('users').add({
        'name': name,
        'photoUrl': photoUrl,
        'password': password,
        'phoneNumber': phoneNumber,
        'isAdmin': false, // Add the 'isAdmin' field with a default value
      });
      print('User data added successfully.');
    } catch (error) {
      print('Error adding user data: $error');
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
        salonList.add(doc.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print("Error fetching salons: $e");
    }
    return salonList;
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

  Future<List<Map<String, dynamic>>> fetchTreatments() async {
    List<Map<String, dynamic>> treatmentList = [];
    try {
      QuerySnapshot snapshot = await _firestore.collection('treatments').get();

      snapshot.docs.forEach((doc) {
        treatmentList.add(doc.data() as Map<String, dynamic>);
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
}
