import 'package:cloud_firestore/cloud_firestore.dart';

class Bus {
  final String busId;
  final String busName;
  final String busNumber;
  final DateTime dateTime;
  final String from;
  final String to;
  final List seat;
  final int costPerSeat;

  Bus({
    required this.busId,
    required this.busName,
    required this.busNumber,
    required this.dateTime,
    required this.from,
    required this.to,
    required this.seat,
    required this.costPerSeat,
  });

  // Factory constructor to create Bus from Firestore data (assuming correct field names)
  factory Bus.fromFirestore(Map<String, dynamic> data) {
    return Bus(
      busId: data['busId'] as String,
      busName: data['busName'] as String,
      busNumber: data['busNumber'] as String,
      dateTime: (data['dateTime'] as Timestamp)
          .toDate(), // Assuming dateTime is stored as Timestamp
      from: data['from'] as String,
      to: data['to'] as String,
      seat: data['seat'] as List,
      costPerSeat: data['costPerSeat'] as int,
    );
  }
}
