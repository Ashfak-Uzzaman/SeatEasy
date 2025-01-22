import 'package:flutter/material.dart';
import 'package:seat_easy/constants/routes.dart';
import 'package:seat_easy/services/auth/auth_service.dart';
import 'package:seat_easy/views/user_pages/account_page.dart';
import 'package:seat_easy/views/user_pages/home_page.dart';
import 'package:seat_easy/views/user_pages/ticket_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;

  final _screens = [BusBookingScreen(), TicketPage(), AccountPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[index],
      bottomNavigationBar: NavigationBar(
        height: 75,
        indicatorColor: Colors.grey[300],
        backgroundColor: Colors.grey,
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
              size: 35,
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
              size: 35,
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
              size: 35,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
