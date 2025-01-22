import 'package:flutter/material.dart';
import 'package:seat_easy/constants/routes.dart';
import 'package:seat_easy/views/admin_fragments/booking_page.dart';
import 'package:seat_easy/views/admin_fragments/bus_page.dart';
import 'package:seat_easy/views/admin_fragments/customer_page.dart';
import 'package:seat_easy/views/admin_fragments/route_page.dart';

class AdminMainView extends StatefulWidget {
  const AdminMainView({super.key});

  @override
  State<AdminMainView> createState() => _AdminMainViewState();
}

class _AdminMainViewState extends State<AdminMainView> {
  int _selected = 1;
  final _screens = [
    const BusPage(),
    const RoutePage(),
    const BookingPage(),
    const CustomerPage(),
  ];
  void changeSelected(int index) {
    setState(() {
      _selected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selected],
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () async {
              //await AuthService.firebase().logOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(
              child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.black),
                  accountName: Text("Admin"),
                  accountEmail: Text("admin@seateasy.com")),
            ),
            ListTile(
              title: const Text('Buses'),
              leading: Image.asset(
                'lib/assets/icons/bus.png',
                width: 24,
                height: 24,
              ),
              onTap: () {
                changeSelected(0);
              },
            ),
            ListTile(
              title: const Text('Routes'),
              selected: true,
              leading: Image.asset(
                'lib/assets/icons/route.png',
                width: 24,
                height: 24,
              ),
              onTap: () {
                changeSelected(1);
              },
            ),
            ListTile(
              title: const Text('Bookings'),
              leading: Image.asset(
                'lib/assets/icons/booking.png',
                width: 24,
                height: 24,
              ),
              onTap: () {
                changeSelected(2);
              },
            ),
            ListTile(
              title: const Text('Customers'),
              leading: const Icon(Icons.people),
              onTap: () {
                changeSelected(3);
              },
            ),
            ListTile(
              title: const Text('Add New Admin'),
              leading: const Icon(Icons.lock_person_outlined),
              onTap: () async {},
            ),
          ],
        ),
      ),
    );
  }
}
