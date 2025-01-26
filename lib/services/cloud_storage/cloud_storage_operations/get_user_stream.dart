import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seat_easy/services/auth/auth_service.dart';

Stream<QuerySnapshot> getUserStream({required bool allUser}) {
  if (allUser) {
    return FirebaseFirestore.instance.collection('UserDB').snapshots();
  }
  final String userId = AuthService.firebase().currentUser!.id;

  return FirebaseFirestore.instance
      .collection('UserDB')
      .where('UserId', isEqualTo: userId)
      .snapshots();
}
