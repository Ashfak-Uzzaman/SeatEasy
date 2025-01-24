import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addBus(String busName, String busNumber) async {
  // Reference to the collection
  CollectionReference buses = FirebaseFirestore.instance.collection('BusDB');

  // Data for the new bus
  Map<String, dynamic> newBus = {
    'BusName': busName,
    'BusNumber': busNumber,
    'DateTime': DateTime.now(),
    'From': '',
    'To': '',
    'Seat': List<bool>.filled(30, false), // 30 boolean values, all false
    'CostPerSeat': 0,
    'Day': '0',
    'Month': '0',
    'Year': '0',
  };

  try {
    // Add a new document with generated ID
    await buses.add(newBus);
    //print('Bus added successfully!');
  } catch (e) {
    //print('Hello You are failed Ashfak');
    //print('Failed to add bus: $e');
  }
}
