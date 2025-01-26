import 'package:flutter/material.dart';
import 'package:seat_easy/components/my_button.dart';
import 'package:seat_easy/components/my_snack_bar.dart';
import 'package:seat_easy/constants/cities.dart';
import 'package:seat_easy/services/cloud_storage/cloud_storage_exceptions.dart';
import 'package:seat_easy/services/cloud_storage/cloud_storage_operations/add_update_route_schedule_cost.dart';
import 'package:seat_easy/utilities/picker/date_time_picker.dart';
import 'package:seat_easy/utilities/update_suggession.dart';

Future<void> openUpdateServicePopup({
  required BuildContext context,
  required TextEditingController busNameController,
  required TextEditingController busNumberController,
  required TextEditingController fromController,
  required TextEditingController toController,
  required TextEditingController costController,
  required String dateTime,
}) {
  String selectedDateTimeToView = '';

  return showDialog<void>(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Update Details'),
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
                      fromController.text = selection;
                    });
                  },
                  fieldViewBuilder:
                      (context, fromController, focusNode, onEditingComplete) {
                    return TextField(
                      controller: fromController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Icons.add_location_alt, color: Colors.green),
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
                      toController.text = selection;
                    });
                  },
                  fieldViewBuilder:
                      (context, toController, focusNode, onEditingComplete) {
                    return TextField(
                      controller: toController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Icons.add_location_alt, color: Colors.blue),
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
                    String? selected = await pickDateTime(
                      context: context,
                      currentTime: false,
                    );

                    setState(() {
                      dateTime = selected ?? dateTime;

                      selectedDateTimeToView = dateTime;
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
                          selectedDateTimeToView,
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
                    onTap: () async {
                      if (busNameController.text.isNotEmpty &&
                          busNumberController.text.isNotEmpty &&
                          fromController.text.isNotEmpty &&
                          toController.text.isNotEmpty &&
                          dateTime.compareTo('') != 0 &&
                          costController.text.isNotEmpty) {
                        try {
                          await updateBusRouteScheduleCost(
                            busName: busNameController.text,
                            busNumber: busNumberController.text,
                            from: fromController.text,
                            to: toController.text,
                            dateTime: dateTime,
                            cost: int.parse(costController.text),
                            isInService: true,
                            year: dateTime.substring(0, 4),
                            month: dateTime.substring(5, 7),
                            day: dateTime.substring(8, 10),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        } on NotMatchingException {
                          // ignore: use_build_context_synchronously
                          showSnackbar(
                              message:
                                  'Bus Name and Number is Not Matching With the available Data in Database',
                              // ignore: use_build_context_synchronously
                              context: context);
                        } on FaildToUpdateException {
                          showSnackbar(
                              message: 'Filed to Update',
                              // ignore: use_build_context_synchronously
                              context: context);
                        } catch (e) {
                          showSnackbar(
                              message: 'Failed to Update $e',
                              // ignore: use_build_context_synchronously
                              context: context);
                        }
                      } else {
                        //print('Error');
                        showSnackbar(
                            message: 'Can\'t Empty Input Fields',
                            context: context);
                      }
                    },
                    text: 'Update',
                    isEnabled: true),
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
              width: 110,
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                try {
                  await updateBusRouteScheduleCost(
                    busName: busNameController.text,
                    busNumber: busNumberController.text,
                    from: '',
                    to: '',
                    dateTime: dateTime,
                    cost: int.parse(costController.text),
                    isInService: false,
                    year: '',
                    month: '',
                    day: '',
                  );
                } catch (e) {
                  // print('$e');
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
