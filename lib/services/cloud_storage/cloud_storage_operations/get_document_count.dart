import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> getDocumentCount(String collectionName) async {
  try {
    // Fetch all documents in the specified collection
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collectionName).get();

    print(querySnapshot.docs.length);

    // Return the count of documents
    return querySnapshot.docs.length;
  } catch (e) {
    print("Error fetching document count: $e");
    return 0; // Return 0 in case of an error
  }
}
