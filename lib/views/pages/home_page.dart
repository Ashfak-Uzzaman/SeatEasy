import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BusBookingScreen extends StatefulWidget {
  const BusBookingScreen({super.key});

  @override
  State<BusBookingScreen> createState() => _BusBookingScreenState();
}

class _BusBookingScreenState extends State<BusBookingScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/assets/images/apple.png'), // Place image in assets folder
                fit: BoxFit.cover,
              ),
            ),
          ),
          // UI Card
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
                  const SizedBox(
                    height: 10,
                  ),

                  // From Input

                  TextField(
                    controller: fromController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.place, color: Colors.green),
                      labelText: "From",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  // To Input

                  TextField(
                    controller: toController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.place, color: Colors.blue),
                      labelText: "To",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      // Journey Date Picker
                      Expanded(
                        child: GestureDetector(
                          onTap: _pickDate,
                          child: Container(
                            height: 60,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.date_range,
                                    color: Colors.orange),
                                const SizedBox(width: 10),
                                Text(
                                  selectedDate,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      // Search Button
                      ElevatedButton(
                        onPressed: () {
                          // Handle Search Action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              vertical: 18, horizontal: 25),
                        ),
                        child: const Text(
                          'SEARCH',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
