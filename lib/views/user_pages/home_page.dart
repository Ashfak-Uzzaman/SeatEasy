import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seat_easy/components/my_button.dart';
import 'package:seat_easy/constants/cities.dart';

class BusBookingScreen extends StatefulWidget {
  const BusBookingScreen({super.key});

  @override
  State<BusBookingScreen> createState() => _BusBookingScreenState();
}

class _BusBookingScreenState extends State<BusBookingScreen> {
  String selectedFrom = '';
  String selectedTo = '';
  String selectedDate = 'Pick a date';

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

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
                Row(
                  children: [
                    Radio(value: true, groupValue: true, onChanged: (_) {}),
                    const Text('One Way'),
                    const SizedBox(width: 20),
                    Radio(value: false, groupValue: true, onChanged: (_) {}),
                    const Text('Round Way'),
                  ],
                ),
                const SizedBox(height: 10),

                // From Autocomplete Input
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) =>
                      updateSuggestions(textEditingValue),
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
                      updateSuggestions(textEditingValue),
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
                  onTap: _pickDate,
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
                          selectedDate,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),

                MyButton(onTap: () {}, text: 'SEARCH', isEnabled: true),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
