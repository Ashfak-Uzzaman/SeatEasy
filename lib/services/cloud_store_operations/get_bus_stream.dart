import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getBusesStream({
  required bool activeBus,
}) {
  if (activeBus) {
    return FirebaseFirestore.instance
        .collection('BusDB')
        .where('IsInService', isEqualTo: true)
        .snapshots();
  }
  return FirebaseFirestore.instance.collection('BusDB').snapshots();
}
