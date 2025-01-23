import 'package:flutter/material.dart';
import 'package:seat_easy/components/my_button.dart';
import 'package:seat_easy/constants/cities.dart';
import 'package:seat_easy/services/cloud_store_operations/add_update_route_schedule_cost.dart';
import 'package:seat_easy/utilities/picker/date_time_picker.dart';
import 'package:seat_easy/utilities/update_suggession.dart';

Future<void> openAssignServicePopup({
  required BuildContext context,
  required TextEditingController busNameController,
  required TextEditingController busNumberController,
  required TextEditingController fromController,
  required TextEditingController toController,
  required TextEditingController costController,
}) {
  String selectedFrom = '';
  String selectedTo = '';
  String selectedDateTime = 'Depature Date and Time';

  return showDialog<void>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Add a Bus'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10.0),
                TextField(
                  controller: busNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.bus_alert, color: Colors.blue),
                    labelText: "Bus Name",
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(
                      maxHeight: 50.0,
                      maxWidth: 450.0,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: busNumberController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.book, color: Colors.blue),
                    labelText: "Bus Number",
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(
                      maxHeight: 50.0,
                      maxWidth: 450.0,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // From Autocomplete Input
                // From Autocomplete Input
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) =>
                      updateSuggestions(textEditingValue, cities),
                  onSelected: (String selection) {
                    setState(() {
                      selectedFrom = selection;
                    });
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    return TextField(
                      controller: fromController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.place, color: Colors.green),
                        labelText: "From",
                        border: OutlineInputBorder(),
                        constraints: BoxConstraints(
                          maxHeight: 50.0,
                          maxWidth: 450.0,
                        ),
                      ),
                      onEditingComplete: onEditingComplete,
                    );
                  },
                ),
                const SizedBox(height: 10),

                // To Autocomplete Input
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) =>
                      updateSuggestions(textEditingValue, cities),
                  onSelected: (String selection) {
                    setState(() {
                      selectedTo = selection;
                      toController.text = selection;
                    });
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    return TextField(
                      controller: toController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.place, color: Colors.blue),
                        labelText: "To",
                        border: OutlineInputBorder(),
                        constraints: BoxConstraints(
                          maxHeight: 50.0,
                          maxWidth: 450.0,
                        ),
                      ),
                      onEditingComplete: onEditingComplete,
                    );
                  },
                ),
                const SizedBox(height: 10),

                // Date Picker
                GestureDetector(
                  onTap: () async {
                    String? selected = await pickDateTime(context);

                    setState(() {
                      selectedDateTime = selected ?? 'Depature Date and Time';
                    });
                  },
                  child: Container(
                    height: 50.0,
                    width: 450.0,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.date_range, color: Colors.orange),
                        const SizedBox(width: 10),
                        Text(
                          selectedDateTime,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: costController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.currency_exchange_rounded,
                        color: Colors.blue),
                    labelText: "Cost",
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(
                      maxHeight: 50.0,
                      maxWidth: 450.0,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                MyButton(
                    onTap: () {}, text: 'Update Bus Route', isEnabled: true),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('SUBMIT'),
              onPressed: () async {
                if (costController.text.trim().isEmpty) {
                  print('Cost field is empty.');
                  return;
                }
                if (!RegExp(r'^\d+$').hasMatch(costController.text.trim())) {
                  print('Cost field contains invalid characters.');
                  return;
                }

                int cost = int.parse(costController.text.trim());

                int x = int.parse(costController.text);
                try {
                  await updateBusRouteScheduleCost(
                    busName: busNameController.text,
                    busNumber: busNumberController.text,
                    from: fromController.text,
                    to: toController.text,
                    dateTime: selectedDateTime,
                    cost: x,
                  );
                } catch (e) {
                  print('$e');
                  print(x);
                }

                // ignore: use_build_context_synchronously
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    ),
  );
}
