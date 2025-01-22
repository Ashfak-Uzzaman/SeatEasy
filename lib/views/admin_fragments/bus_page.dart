import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seat_easy/components/my_button.dart';
import 'package:seat_easy/services/cloud_store_operations/delete_bus.dart';
import 'package:seat_easy/services/cloud_store_operations/get_bus.dart';
import 'package:seat_easy/utilities/popup_textfields/add_bus_popup.dart';

class BusPage extends StatefulWidget {
  const BusPage({super.key});

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  late TextEditingController busNamecontroller;
  late TextEditingController busNumbercontroller;

  @override
  void initState() {
    super.initState();
    busNamecontroller = TextEditingController();
    busNumbercontroller = TextEditingController();
  }

  @override
  void dispose() {
    busNamecontroller.dispose();
    busNumbercontroller.dispose();
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
              text: 'Add Bus',
              isEnabled: true,
              onTap: () async {
                await openAddBusPopup(
                  context: context,
                  busNameController: busNamecontroller,
                  busNumberController: busNumbercontroller,
                );
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
              stream: getBusesStream(),
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
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        title: Text(
                          bus['BusName'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(
                          '${bus['BusNumber']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              await deleteBus(bus.id); // bus.id = document ID
                            },
                            icon: const Icon(Icons.delete)),
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
