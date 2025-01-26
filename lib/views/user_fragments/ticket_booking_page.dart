import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seat_easy/components/my_button.dart';

import 'package:seat_easy/constants/seats.dart';

import 'package:seat_easy/utilities/popups/confirm_booking_popup.dart';

class TicketBookingPage extends StatefulWidget {
  const TicketBookingPage({
    super.key,
    required this.busRef,
    required this.seatStatusArray,
    required this.costPerSeat,
    required this.ticket,
  });

  final dynamic
      busRef; // Assuming dynamic type for now, update based on actual type
  final List<dynamic> seatStatusArray;
  final int costPerSeat;
  final String ticket;

  @override
  State<TicketBookingPage> createState() => _TicketBookingPageState();
}

class _TicketBookingPageState extends State<TicketBookingPage> {
  final int totalSeats = 32;
  late int cost;
  int totalCost = 0;
  List<bool> selectedSeats = List.generate(32, (index) => false);

  late List<dynamic> seatStatus;
  late DocumentReference busRef;
  late String ticket;
  late String selectedSeatName;

  @override
  void initState() {
    super.initState();
    cost = widget.costPerSeat;
    seatStatus = widget.seatStatusArray;
    busRef = widget.busRef;
    ticket = widget.ticket;
    selectedSeatName = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Total Cost: $totalCost.00 /-',
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // 4 seats + 1 gap
                  crossAxisSpacing:
                      8, // horizontal spacing between items in a row
                  mainAxisSpacing:
                      10, // Specifies the vertical spacing between rows
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
                        if (!seatStatus[seatIndex]) {
                          selectedSeats[seatIndex] = !selectedSeats[seatIndex];
                          //seatStatus[seatIndex] = selectedSeats[seatIndex];
                          totalCost +=
                              selectedSeats[seatIndex] ? cost : (-1 * cost);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: seatStatus[seatIndex]
                            ? Colors.red
                            : selectedSeats[seatIndex]
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
              ),
            ),
          ),
          // Button below the grid
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 30),
            child: MyButton(
                onTap: () {
                  for (int i = 0; i < seatStatus.length; i++) {
                    seatStatus[i] =
                        selectedSeats[i] ? selectedSeats[i] : seatStatus[i];

                    selectedSeatName = selectedSeats[i]
                        ? '$selectedSeatName${seats[i]} '
                        : selectedSeatName;
                  }
                  //print('$selectedSeatName');

                  confirmBookingPopup(
                    context: context,
                    totalCost: totalCost,
                    busRef: busRef,
                    seatStatusArray: seatStatus,
                    ticket: ticket,
                    selectedSeatName: selectedSeatName,
                  );
                  //Navigator.pop(context);
                  /*Navigator.of(context)
                      .pushNamedAndRemoveUntil(homeRoute,(route) => false);*/
                },
                text: 'Continue',
                isEnabled: true),
          ),
        ],
      ),
    );
  }
}
