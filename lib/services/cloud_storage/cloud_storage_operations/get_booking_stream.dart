import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getBookingStream() {
  return FirebaseFirestore.instance.collection('TicketDB').snapshots();
}
