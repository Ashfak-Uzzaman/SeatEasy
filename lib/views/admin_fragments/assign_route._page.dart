import 'package:flutter/material.dart';
import 'package:seat_easy/components/my_button.dart';

import 'package:seat_easy/constants/cities.dart';
import 'package:seat_easy/services/cloud_store_operations/add_update_route_schedule_cost.dart';
import 'package:seat_easy/utilities/picker/date_time_picker.dart';
import 'package:seat_easy/utilities/update_suggession.dart';

class AssignRoutePage extends StatefulWidget {
  const AssignRoutePage({super.key});

  @override
  State<AssignRoutePage> createState() => _AssignRoutePageState();
}

class _AssignRoutePageState extends State<AssignRoutePage> {
  late TextEditingController busNameController;
  late TextEditingController busNumberController;
  late TextEditingController fromController;
  late TextEditingController toController;
  late TextEditingController costController;
  String selectedFrom = '';
  String selectedTo = '';
  String selectedDateTime = '';
  String selectedDateTimeToView = 'Date and Time';

  @override
  void initState() {
    super.initState();
    // Initialize the TextEditingControllers
    busNameController = TextEditingController();
    busNumberController = TextEditingController();
    fromController = TextEditingController();
    toController = TextEditingController();
    costController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose of the TextEditingControllers to free up resources
    busNameController.dispose();
    busNumberController.dispose();
    fromController.dispose();
    toController.dispose();
    costController.dispose();
    super.dispose();
  }

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(27, 20, 27, 0),
              child: TextField(
                controller: busNameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.bus_alert, color: Colors.blue),
                  labelText: "Bus Name",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),

            //const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(27, 20, 27, 0),
              child: TextField(
                controller: busNumberController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.calendar_view_day, color: Colors.blue),
                  labelText: "Bus Number",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),

            //const SizedBox(height: 20.0),

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
                return Padding(
                  padding: const EdgeInsets.fromLTRB(27, 20, 27, 0),
                  child: TextField(
                    controller: fromController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.add_location_alt, color: Colors.blue),
                      labelText: "From",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onEditingComplete: onEditingComplete,
                  ),
                );
              },
            ),

            //const SizedBox(height: 20.0),

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
                return Padding(
                  padding: const EdgeInsets.fromLTRB(27, 20, 27, 0),
                  child: TextField(
                    controller: toController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      prefixIcon:
                          Icon(Icons.add_location_alt, color: Colors.blue),
                      labelText: "To",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onEditingComplete: onEditingComplete,
                  ),
                );
              },
            ),

            //const SizedBox(height: 20.0),

            // Date Picker
            GestureDetector(
              onTap: () async {
                String? selected = await pickDateTime(context);

                setState(() {
                  selectedDateTime = selected ?? '';

                  selectedDateTimeToView = (selectedDateTime.compareTo('') != 0)
                      ? '${selectedDateTime.substring(0, 10)}\n${selectedDateTime.substring(11)}'
                      : 'Date and Time';
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(27, 20, 27, 0),
                child: Container(
                  height: 60.0,
                  width: 450.0,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
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
            ),

            //const SizedBox(height: 20.0),

            Padding(
              padding: const EdgeInsets.fromLTRB(27, 20, 27, 0),
              child: TextField(
                controller: costController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.currency_exchange, color: Colors.blue),
                  labelText: "Cost",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50.0),

            MyButton(
                /*onTap: () {
                  print('${fromController.text}->${toController.text}->');
                },*/
                onTap: () async {
                  if (busNameController.text.isNotEmpty &&
                      busNumberController.text.isNotEmpty &&
                      fromController.text.isNotEmpty &&
                      toController.text.isNotEmpty &&
                      selectedDateTime.compareTo('') != 0 &&
                      costController.text.isNotEmpty) {
                    try {
                      await updateBusRouteScheduleCost(
                        busName: busNameController.text,
                        busNumber: busNumberController.text,
                        from: fromController.text,
                        to: toController.text,
                        dateTime: selectedDateTime,
                        cost: int.parse(costController.text),
                        isInService: true,
                      );
                    } catch (e) {
                      //print('$e');
                    }
                  } else {
                    print('Error');
                  }

                  // ignore: use_build_context_synchronously
                  //Navigator.pop(context);
                },
                text: 'SUBMIT',
                isEnabled: true),
          ],
        ),
      ),
    );
  }
}
