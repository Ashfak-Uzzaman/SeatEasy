import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> getAllBuses() async {
  CollectionReference buses = FirebaseFirestore.instance.collection('BusDB');

  try {
    QuerySnapshot querySnapshot = await buses.get();

    for (var doc in querySnapshot.docs) {
      print('Document ID: ${doc.id}');
      print('Data: ${doc.data()}');

      Object? bus = doc.data();
    }
  } catch (e) {
    print('Failed to get buses: $e');
  }
}
