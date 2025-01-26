import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seat_easy/services/cloud_storage/cloud_storage_operations/get_bus_stream.dart';
import 'package:seat_easy/views/user_fragments/ticket_booking_page.dart';

class ShowBusPage extends StatefulWidget {
  final String fromDestination;
  final String toDestination;
  final String dateTime;
  const ShowBusPage(
      {super.key,
      required this.fromDestination,
      required this.toDestination,
      required this.dateTime});

  @override
  State<ShowBusPage> createState() => _ShowBusPageState();
}

class _ShowBusPageState extends State<ShowBusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black,
        toolbarHeight: 100.0,
        title: Text(
          '${widget.fromDestination}   ➔   ${widget.toDestination}\n'
          '${widget.dateTime.substring(8, 10)} - ${widget.dateTime.substring(5, 7)} - ${widget.dateTime.substring(0, 4)}',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getBusesStream(
                activeBus: true,
                fromDestination: widget.fromDestination,
                toDestination: widget.toDestination,
                dateTime: widget.dateTime),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              // snapshot.data! -> By using ! operator, you are telling the compiler the variable won't be null.
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text(widget.dateTime);
              }

              // Build a list of buses
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var bus = snapshot.data!.docs[
                      index]; // QueryDocumentSnapshot<Object?> bus =  snapshot.data!.docs[index];
                  //String busId = bus.id; // The document's ID

                  // Here busRef is the direct reference of the document in firestore
                  DocumentReference busRef = FirebaseFirestore.instance
                      .collection('BusDB')
                      .doc(bus.id);

                  var seatStatusArray = bus['Seat'];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      onTap: () {
                        //print('haha hihi huhu');
                        //print(seatStatusArray);
                        final String busName = bus['BusName'];
                        final String ticket =
                            '$busName\n${widget.fromDestination} ➜ ${widget.toDestination}\n${widget.dateTime.substring(8, 10)} - ${widget.dateTime.substring(5, 7)} - ${widget.dateTime.substring(0, 4)}\n${widget.dateTime.substring(11, 13)} :  ${widget.dateTime.substring(14, 16)}\n';
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TicketBookingPage(
                                      busRef: busRef,
                                      seatStatusArray: seatStatusArray,
                                      costPerSeat: bus['Cost'],
                                      ticket: ticket,
                                    )));
                      },
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      title: Text(
                        '${bus['BusName']}\n'
                        'Depature Time: ${DateFormat('HH:mm').format(bus['DateTime'].toDate())}\n',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        'Cost Per Seat: ${bus['Cost']}/-\n'
                        'Available Seat(s): ${bus['Seat'].where((value) => !value).length}',
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
      ),
    );
  }
}
