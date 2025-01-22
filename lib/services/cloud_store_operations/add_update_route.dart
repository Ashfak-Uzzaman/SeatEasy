import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateBusRouteByDetails({
  required String busName,
  required String busNumber,
  required String from,
  required String to,
  required String dateTime,
}) async {
  try {
    // Query the Firestore collection to find the document
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('BusDB')
        .where('BusName', isEqualTo: busName)
        .where('BusNumber', isEqualTo: busNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Get the document ID of the matching document
      String docId = querySnapshot.docs.first.id;

      // Update the document fields
      await FirebaseFirestore.instance.collection('BusDB').doc(docId).update({
        'From': from,
        'To': to,
        'DateTime': DateTime.parse(dateTime),
      });

      print('Bus route updated successfully!');
    } else {
      print('No matching bus found for the given BusName and BusNumber.');
    }
  } catch (e) {
    print('Failed to update bus route: $e');
  }
}
