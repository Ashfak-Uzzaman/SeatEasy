import 'package:cloud_firestore/cloud_firestore.dart';

Stream<QuerySnapshot> getBusesStream({
  required bool activeBus,
  required String fromDestination,
  required String toDestination,
  required String? dateTime,
}) {
  if (dateTime != null) {
    return FirebaseFirestore.instance
        .collection('BusDB')
        .where('From', isEqualTo: fromDestination)
        .where('IsInService', isEqualTo: true)
        .where('To', isEqualTo: toDestination)
        .where('Year', isEqualTo: dateTime.substring(0, 4))
        .where('Month', isEqualTo: dateTime.substring(5, 7))
        .where('Day', isEqualTo: dateTime.substring(8, 10))
        .snapshots();
  }
  if (fromDestination.isNotEmpty && toDestination.isNotEmpty) {
    return FirebaseFirestore.instance
        .collection('BusDB')
        .where('IsInService', isEqualTo: true)
        .where('From', isEqualTo: fromDestination)
        .where('To', isEqualTo: toDestination)
        .snapshots();
  }
  if (activeBus) {
    return FirebaseFirestore.instance
        .collection('BusDB')
        .where('IsInService', isEqualTo: true)
        .snapshots();
  }
  return FirebaseFirestore.instance.collection('BusDB').snapshots();
}


// import 'package:cloud_firestore/cloud_firestore.dart';

// Stream<QuerySnapshot> getBusesStream({
//   required bool activeBus,
//   required String fromDestination,
//   required String toDestination
// }) {

//     return FirebaseFirestore.instance
//         .collection('BusDB')
//         .where('IsInService', isEqualTo: true)
//         .where('From',isEqualTo: fromDestination)
//         .where('To',isEqualTo: toDestination)
//         .snapshots();

  

// }

