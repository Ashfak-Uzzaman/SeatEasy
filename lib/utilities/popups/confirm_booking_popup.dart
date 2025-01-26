import 'package:flutter/material.dart';
import 'package:seat_easy/components/my_snack_bar.dart';
import 'package:seat_easy/constants/routes.dart';
import 'package:seat_easy/services/cloud_storage/cloud_storage_operations/create_ticket.dart';

import 'package:seat_easy/services/cloud_storage/cloud_storage_operations/book_seat.dart';

Future<void> confirmBookingPopup({
  required BuildContext context,
  required int totalCost,
  required busRef,
  required seatStatusArray,
  required ticket,
  required selectedSeatName,
}) =>
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
            child: Text(
          'Confirm Booking',
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        content: SingleChildScrollView(
          // Use SingleChildScrollView to allow for smaller dialogs
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Ensures the column takes up minimal vertical space
            children: [
              Text(
                'Total Cost: $totalCost',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Radio(value: true, groupValue: true, onChanged: (_) {}),
                  const Text('Card'),
                  const SizedBox(width: 20),
                  Radio(value: false, groupValue: true, onChanged: (_) {}),
                  const Text('Online Payment'),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              const TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: 'Enter Account Number'),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(hintText: 'Enter Password'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
          ),
          const SizedBox(
            width: 100,
          ),
          TextButton(
            child: const Text('SUBMIT'),
            onPressed: () async {
              ticket = '$ticket$selectedSeatName\n$totalCost /-';
              try {
                // ignore: use_build_context_synchronously
                bookSeat(bus: busRef, seatStatus: seatStatusArray);
                //print(ticket);
                createTicket(ticket: ticket);
                showSnackbar(message: 'Booking Successful', context: context);
                // Close the dialog
              } catch (e) {
                showSnackbar(message: 'Failed to Book', context: context);
              }
              // Navigator.pop(context);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(homeRoute, (route) => false);
            },
          ),
        ],
      ),
    );
