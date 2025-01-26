import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:seat_easy/services/cloud_storage/cloud_storage_operations/get_user_stream.dart';
import 'package:seat_easy/utilities/launch_mail.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Customers/ Users List:',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView(
          //padding: const EdgeInsets.all(32),
          children: [
            const SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: getUserStream(allUser: true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                // snapshot.data! -> By using ! operator, you are telling the compiler the variable won't be null.
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No Bookings Available.');
                }

                // Build a list of buses
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var user = snapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        title: Text(
                          'Name: ${user['UserName']}\n'
                          'Email: ${user['Email']}\n'
                          'Phone: ${user['Phone']}\n',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Text(
                          'User ID: ${user['UserId']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              launchEmail(
                                '${user['Email']}',
                                'Seat Easy Customer Service',
                                'Assalamualaikum',
                              );
                              Uri.parse(
                                  "mailto: ${user['Email']}?subject=Seat Easy Customer Service&body=Assalamualaikum");
                            },
                            icon: const Icon(Icons.email)),
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
