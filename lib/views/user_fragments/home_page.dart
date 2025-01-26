import 'package:flutter/material.dart';

import 'package:seat_easy/components/my_button.dart';
import 'package:seat_easy/constants/cities.dart';
import 'package:seat_easy/utilities/picker/date_time_picker.dart';
import 'package:seat_easy/utilities/popups/confirm_booking_popup.dart';
import 'package:seat_easy/utilities/update_suggession.dart';
import 'package:seat_easy/views/user_fragments/show_bus_page.dart';

class BusBookingScreen extends StatefulWidget {
  const BusBookingScreen({super.key});

  @override
  State<BusBookingScreen> createState() => _BusBookingScreenState();
}

class _BusBookingScreenState extends State<BusBookingScreen> {
  late TextEditingController busNameController;
  late TextEditingController busNumberController;
  late TextEditingController fromController;
  late TextEditingController toController;
  late TextEditingController costController;

  String selectedDate = '';
  String selectedDateToView = 'Pick a Date';

  @override
  void initState() {
    super.initState();
    // Initialize the TextEditingControllers
    fromController = TextEditingController();
    toController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose of the TextEditingControllers to free up resources
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Pick Route and Date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),

                const SizedBox(height: 20),

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
                      (context, controller, focusNode, onEditingComplete) {
                    controller.addListener(() {
                      fromController.text = controller.text;
                    });
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.place, color: Colors.green),
                        labelText: "From",
                        border: OutlineInputBorder(),
                        constraints: BoxConstraints(
                          maxHeight: 100.0,
                          maxWidth: 450.0,
                        ),
                      ),
                      onEditingComplete: onEditingComplete,
                    );
                  },
                ),
                const SizedBox(height: 20),

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
                      (context, controller, focusNode, onEditingComplete) {
                    controller.addListener(() {
                      toController.text = controller.text;
                    });
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.place, color: Colors.blue),
                        labelText: "To",
                        border: OutlineInputBorder(),
                        constraints: BoxConstraints(
                          maxHeight: 100.0,
                          maxWidth: 450.0,
                        ),
                      ),
                      onEditingComplete: onEditingComplete,
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Date Picker
                GestureDetector(
                  onTap: () async {
                    String? selected =
                        await pickDateTime(context: context, currentTime: true);

                    setState(() {
                      selectedDate = selected ?? '';

                      selectedDateToView = (selectedDate.compareTo('') != 0)
                          ? selectedDate.substring(0, 10)
                          : 'Pick a date';
                    });
                  },
                  child: Container(
                    height: 60.0,
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
                          selectedDateToView,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),

                MyButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ShowBusPage(
                                fromDestination: fromController.text,
                                toDestination: toController.text,
                                dateTime: selectedDate)),
                      );
                    },
                    text: 'SEARCH',
                    isEnabled: true),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
