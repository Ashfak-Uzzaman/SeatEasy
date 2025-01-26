import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seat_easy/services/auth/auth_service.dart';
import 'package:seat_easy/services/cloud_storage/cloud_storage_exceptions.dart';

Future<void> updateUser({
  required String name,
  required String phone,
}) async {
  try {
    String userId = AuthService.firebase().currentUser!.id;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('UserDB')
        .where('UserId', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      //print('Hi');
      String docId =
          querySnapshot.docs.first.id; // document ID of the matching document

      // Update document
      await FirebaseFirestore.instance.collection('UserDB').doc(docId).update({
        'UserName': name,
        'Phone': phone,
      });

      //print('Bus route updated successfully!');
    } else {
      //print('No matching bus found for the given BusName and BusNumber.');
      throw NotMatchingException();
    }
  } catch (e) {
    //print('Failed to update bus route: $e');
    throw FaildToUpdateException();
  }
}
