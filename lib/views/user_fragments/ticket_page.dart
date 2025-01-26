import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seat_easy/services/cloud_storage/cloud_storage_operations/get_ticket_stream.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 40.0,
        title: const Text(
          'Your Tickets',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getTicketStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                    child: Text("You didn't reserved any ticket through us!"));
              }

              // Build a list of buses
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var ticket = snapshot.data!.docs[index];

                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: ListTile(
                      tileColor: Colors.grey[700],
                      onTap: () {},
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        '${ticket['Tickets']}\n@seateasy.com',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
