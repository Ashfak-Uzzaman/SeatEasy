import 'package:flutter/material.dart';
import 'package:seat_easy/constants/seats.dart';

class TicketBookingPage extends StatefulWidget {
  const TicketBookingPage({super.key});

  @override
  State<TicketBookingPage> createState() => _TicketBookingPageState();
}

class _TicketBookingPageState extends State<TicketBookingPage> {
  final int totalSeats = 32;
  List<bool> selectedSeats = List.generate(32, (index) => false);

  late List<bool> bookedSeats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Seat Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // 4 seats + 1 gap
                  crossAxisSpacing:
                      8, // horizontal spacing between items in a row
                  mainAxisSpacing:
                      16, // Specifies the vertical spacing between rows
                ),
                itemCount: 40, // 32 seats + 8 gaps
                itemBuilder: (context, index) {
                  // Add gaps for the aisle
                  if ((index % 5 == 2)) {
                    return const SizedBox(); // Leave space for the aisle
                  }

                  // Calculate the actual seat index, skipping gaps
                  int seatIndex = seatIndexList[index];

                  // Seat widget
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSeats[seatIndex] = !selectedSeats[seatIndex];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedSeats[seatIndex]
                            ? Colors.green
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        seats[seatIndex],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
