import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateBusRouteScheduleCost({
  required String busName,
  required String busNumber,
  required String from,
  required String to,
  required String dateTime, // DateTime string in ISO 8601 format
  required int cost,
}) async {
  try {
    print('Hi');
    // Query the Firestore collection to find the document
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('BusDB')
        .where('BusName', isEqualTo: busName)
        .where('BusNumber', isEqualTo: busNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print('Hi');
      // Get the document ID of the matching document
      String docId = querySnapshot.docs.first.id;

      // Update the document fields
      await FirebaseFirestore.instance.collection('BusDB').doc(docId).update({
        'From': from,
        'To': to,
        'DateTime': Timestamp.fromDate(
            DateTime.parse(dateTime)), // Convert to Timestamp
        'Cost': cost,
      });

      print('Bus route updated successfully!');
    } else {
      print('No matching bus found for the given BusName and BusNumber.');
    }
  } catch (e) {
    print('Failed to update bus route: $e');
  }
}
