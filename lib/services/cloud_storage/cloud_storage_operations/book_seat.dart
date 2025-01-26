import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seat_easy/services/cloud_storage/cloud_storage_exceptions.dart';

Future<void> bookSeat(
    {required DocumentReference bus, required List<dynamic> seatStatus}) async {
  try {
    // Update specific fields
    await bus.update({
      // Updating the bus name
      'Seat': seatStatus, // Example: setting all seats to true
    });

    ///print('Bus updated successfully!');
  } catch (e) {
    //print('Failed!');
    throw FaildToUpdateException();
  }
}
