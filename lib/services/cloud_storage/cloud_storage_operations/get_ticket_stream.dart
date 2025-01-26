import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seat_easy/services/auth/auth_service.dart';

Stream<QuerySnapshot> getTicketStream() {
  final String userId = AuthService.firebase().currentUser!.id;

  return FirebaseFirestore.instance
      .collection('TicketDB')
      .where('UserId', isEqualTo: userId)
      .snapshots();
}
