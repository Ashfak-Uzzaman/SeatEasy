import 'package:flutter/material.dart';
import 'package:seat_easy/services/cloud_store_operations/add_bus.dart';

Future<void> openAddBusPopup({
  required BuildContext context,
  required TextEditingController busNameController,
  required TextEditingController busNumberController,
}) =>
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add a Bus'),
        content: SingleChildScrollView(
          // Use SingleChildScrollView to allow for smaller dialogs
          child: Column(
            mainAxisSize: MainAxisSize
                .min, // Ensures the column takes up minimal vertical space
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Enter Bus Name'),
                controller: busNameController,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(hintText: 'Enter Bus Number'),
                controller: busNumberController,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('SUBMIT'),
            onPressed: () async {
              await addBus(busNameController.text, busNumberController.text);
              busNameController.clear();
              busNumberController.clear();
              Navigator.pop(context); // Close the dialog
            },
          ),
        ],
      ),
    );
