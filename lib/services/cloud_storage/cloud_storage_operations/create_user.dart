import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seat_easy/services/cloud_storage/cloud_storage_exceptions.dart';

Future<void> createUser(
    String userId, String userName, String email, String phone) async {
  // Reference to the collection
  CollectionReference users = FirebaseFirestore.instance.collection('UserDB');

  // Data for the new bus
  Map<String, dynamic> newUser = {
    'UserId': userId,
    'UserName': userName,
    'Email': email,
    'Phone': phone,
    'Tickets': [],
  };

  try {
    // Add a new document with generated ID
    await users.add(newUser);
    //print('Bus added successfully!');
  } catch (e) {
    throw FaildToRegisterAtDBException();
  }
}
