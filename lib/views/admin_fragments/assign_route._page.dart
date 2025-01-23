import 'package:flutter/material.dart';
import 'package:seat_easy/components/my_button.dart';

import 'package:seat_easy/constants/cities.dart';
import 'package:seat_easy/utilities/picker/date_time_picker.dart';
import 'package:seat_easy/utilities/update_suggession.dart';

class AssignRoutePage extends StatefulWidget {
  const AssignRoutePage({super.key});

  @override
  State<AssignRoutePage> createState() => _AssignRoutePageState();
}

class _AssignRoutePageState extends State<AssignRoutePage> {
  String selectedFrom = '';
  String selectedTo = '';
  String selectedDateTime = 'Depature Date and Time';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Assign Bus  to Service',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: SingleChildScrollView(
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
                const SizedBox(height: 20.0),
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.bus_alert, color: Colors.blue),
                    labelText: "Bus Name",
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(
                      maxHeight: 50.0,
                      maxWidth: 450.0,
                    ),
                  ),
                ),

                const SizedBox(height: 20.0),
                const TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.book, color: Colors.blue),
                    labelText: "Bus Number",
                    border: OutlineInputBorder(),
                    constraints: BoxConstraints(
                      maxHeight: 50.0,
                      maxWidth: 450.0,
                    ),
                  ),
                ),

                const SizedBox(height: 20.0),

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
                const SizedBox(height: 20.0),

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
                const SizedBox(height: 20.0),

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
                const SizedBox(height: 20.0),
                const TextField(
                  decoration: InputDecoration(
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

                const SizedBox(height: 20.0),

                MyButton(
                    onTap: () {}, text: 'Update Bus Route', isEnabled: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
