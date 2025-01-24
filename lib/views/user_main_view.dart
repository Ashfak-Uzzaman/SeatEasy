import 'package:flutter/material.dart';
import 'package:seat_easy/constants/routes.dart';
import 'package:seat_easy/services/auth/auth_service.dart';
import 'package:seat_easy/views/user_fragments/account_page.dart';
import 'package:seat_easy/views/user_fragments/home_page.dart';
import 'package:seat_easy/views/user_fragments/ticket_page.dart';

class UserMainView extends StatefulWidget {
  const UserMainView({super.key});

  @override
  State<UserMainView> createState() => _UserMainViewState();
}

class _UserMainViewState extends State<UserMainView> {
  int index = 0;

  final _screens = [
    const BusBookingScreen(),
    const TicketPage(),
    const AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[index],
      bottomNavigationBar: NavigationBar(
        height: 75,
        indicatorColor: const Color.fromARGB(255, 237, 245, 251),
        backgroundColor: Colors.white,
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() => this.index = index),
        destinations: const [
          NavigationDestination(
            label: 'Home',
            icon: Icon(
              Icons.home_outlined,
              size: 30,
            ),
            selectedIcon: Icon(
              Icons.home,
              size: 40,
            ),
          ),
          NavigationDestination(
            label: 'Tickets',
            icon: Icon(
              Icons.airplane_ticket_outlined,
              size: 30,
            ),
            selectedIcon: Icon(
              Icons.airplane_ticket,
              size: 40,
            ),
          ),
          NavigationDestination(
            label: 'Profile',
            icon: Icon(
              Icons.person_2_outlined,
              size: 30,
            ),
            selectedIcon: Icon(
              Icons.person_2,
              size: 40,
            ),
          ),
        ],
      ),
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
              await AuthService.firebase().logOut();
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
      drawer: const Drawer(
        backgroundColor: Colors.blue,
        child: Text(
          'On Progress',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
