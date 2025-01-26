import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seat_easy/services/cloud_storage/cloud_storage_operations/get_booking_stream.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Bookings List:',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView(
          //padding: const EdgeInsets.all(32),
          children: [
            const SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: getBookingStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                // snapshot.data! -> By using ! operator, you are telling the compiler the variable won't be null.
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No Bookings Available.');
                }

                // Build a list of buses
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var ticket = snapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        title: Text(
                          '${ticket['Email']}\n',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          'User ID: ${ticket['UserId']}\nDetails:\n'
                          '${ticket['Tickets']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ));
  }
}
