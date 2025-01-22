import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getBusesStream() {
  return FirebaseFirestore.instance.collection('BusDB').snapshots();
}
