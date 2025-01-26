import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seat_easy/services/auth/auth_service.dart';
import 'package:seat_easy/services/cloud_storage/cloud_storage_exceptions.dart';

Future<void> createTicket({
  required String ticket,
}) async {
  CollectionReference tickets =
      FirebaseFirestore.instance.collection('TicketDB');
  final String userId = AuthService.firebase().currentUser!.id;
  final String email = AuthService.firebase().currentUser!.email;

  Map<String, dynamic> newTicket = {
    'UserId': userId,
    'Email': email,
    'Tickets': ticket,
  };
  try {
    // Add a new document with generated ID
    await tickets.add(newTicket);
    //print('Bus added successfully!');
  } catch (e) {
    throw FaildToRegisterAtDBException();
  }
}
