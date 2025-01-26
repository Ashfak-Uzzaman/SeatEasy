import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seat_easy/services/auth/auth_service.dart';

Future<Map<String, dynamic>?> getUserDetails() async {
  final String userId = AuthService.firebase().currentUser!.id;

  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('UserDB')
        .where('UserId', isEqualTo: userId)
        .get();

    // Check if the document exists
    if (querySnapshot.docs.isNotEmpty) {
      // Extract the first document's data
      Map<String, dynamic> userData =
          querySnapshot.docs.first.data() as Map<String, dynamic>;

      // Return the required fields
      return {
        'UserName': userData['UserName'],
        'Phone': userData['Phone'],
      };
    } else {
      print('No user found with the given UserId.');
      //return null;
      throw Exception();
    }
  } catch (e) {
    print('Error fetching user details: $e');
    //return null;
    throw Exception();
  }
}
