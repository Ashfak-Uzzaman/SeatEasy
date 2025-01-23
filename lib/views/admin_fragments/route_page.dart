import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seat_easy/components/my_button.dart';
import 'package:seat_easy/services/cloud_store_operations/get_bus_stream.dart';

import 'package:seat_easy/utilities/popup_textfields/assign_service_popup.dart';
import 'package:seat_easy/views/admin_fragments/assign_route._page.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  late TextEditingController busNameController;
  late TextEditingController busNumberController;
  late TextEditingController fromController;
  late TextEditingController toController;
  late TextEditingController costController;

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
          title: const Text('Bus Status'),
          centerTitle: true,
        ),
        body: ListView(
          //padding: const EdgeInsets.all(32),
          children: [
            //MyButton(onTap: onTap, text: text, isEnabled: isEnabled)
            MyButton(
              text: 'Add Bus to Service',
              isEnabled: true,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AssignRoutePage()));
              },
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
              child: Text(
                'Bus List:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            StreamBuilder<QuerySnapshot>(
              stream: getBusesStream(activeBus: true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                // snapshot.data! -> By using ! operator, you are telling the compiler the variable won't be null.
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No buses available.');
                }

                // Build a list of buses
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var bus = snapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        onTap: () {
                          busNameController.text = bus['BusName'];
                          busNumberController.text = bus['BusNumber'];
                          fromController.text = bus['From'];
                          toController.text = bus['To'];
                          costController.text = bus['Cost'].toString();
                          openAssignServicePopup(
                              context: context,
                              busNameController: busNameController,
                              busNumberController: busNumberController,
                              fromController: fromController,
                              toController: toController,
                              costController: costController,
                              dateTime: DateFormat('yyyy-MM-ddTHH:mm:ss')
                                  .format(bus['DateTime'].toDate()));
                        },
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        title: Text(
                          '${bus['BusName']}\n'
                          'Route: ${bus['From']} - ${bus['To']}\n'
                          'Trip Date: ${DateFormat('yyyy-MM-dd').format(bus['DateTime'].toDate())}\n'
                          'Depature Time: ${DateFormat('HH:mm').format(bus['DateTime'].toDate())}\n',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          'Bus No.: ${bus['BusNumber']}\n'
                          'Cost Per Seat: ${bus['Cost']}/-\n'
                          'Available Seat(s): ${bus['Seat'].where((value) => !value).length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        /*trailing: IconButton(
                            onPressed: () async {
                              //await deleteBus(bus.id); // bus.id = document ID
                            },
                            icon: const Icon(
                              Icons.edit,
                            )),*/
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ));
  }
}
