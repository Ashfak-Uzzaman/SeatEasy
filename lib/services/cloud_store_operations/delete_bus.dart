import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteBus(String docId) async {
  // Reference to the collection
  DocumentReference bus =
      FirebaseFirestore.instance.collection('BusDB').doc(docId);

  try {
    // Delete the document
    await bus.delete();
    print('Bus deleted successfully!');
  } catch (e) {
    print('Failed to delete bus: $e');
  }
}
