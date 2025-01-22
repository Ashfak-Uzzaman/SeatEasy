import 'package:flutter/material.dart';
import 'package:seat_easy/components/my_button.dart';
import 'package:seat_easy/constants/cities.dart';
import 'package:seat_easy/utilities/picker/date_time_picker.dart';
import 'package:seat_easy/utilities/update_suggessions.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  String selectedFrom = '';
  String selectedTo = '';
  String selectedDateTime = 'Depature Date and Time';
/*
  Future<void> _pickDateTime() async {
    // showDatePicker used to pick a date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // showTimePicker used to pick a time
      TimeOfDay? pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // Combine the date and time
        DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Update state with the selected DateTime
        setState(() {
          selectedDateTime =
              DateFormat('yyyy-MM-dd \n HH:mm').format(pickedDateTime);
        });
      }
    }
  }
*/
/*
// my own logic
  List<String> updateSuggestions(TextEditingValue textEditingValue) {
    if (textEditingValue.text.isEmpty) {
      return const Iterable<String>.empty().toList();
    }
    return cities.where((String place) {
      return place
              .toLowerCase()
              .substring(0, textEditingValue.text.length)
              .compareTo(textEditingValue.text.toLowerCase()) ==
          0;
    }).toList();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      controller: controller,
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
                    });
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    return TextField(
                      controller: controller,
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

                MyButton(
                    onTap: () {}, text: 'Update Bus Route', isEnabled: true),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
