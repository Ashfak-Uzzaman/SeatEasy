import 'package:flutter/material.dart';
import 'package:seat_easy/services/cloud_storage/cloud_storage_operations/get_document_count.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int? totalBus; // Nullable to handle uninitialized state
  int? totalUsers;
  int? totalBookings;
  bool isLoading = true; // Loading indicator

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final busCount = await getDocumentCount('BusDB');
      final userCount = await getDocumentCount('UserDB');
      final bookingCount = await getDocumentCount('TicketDB');

      setState(() {
        totalBus = busCount;
        totalUsers = userCount;
        totalBookings = bookingCount;
        isLoading = false; // Loading complete
      });
    } catch (e) {
      print("Error fetching data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 60),
                  _buildStatBox(
                    title: 'Total Bus',
                    value: totalBus,
                  ),
                  const SizedBox(height: 60),
                  _buildStatBox(
                    title: 'Total Users',
                    value: totalUsers,
                  ),
                  const SizedBox(height: 60),
                  _buildStatBox(
                    title: 'Total Bookings',
                    value: totalBookings,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }

  Widget _buildStatBox({required String title, int? value}) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Text(
        '$title: ${value ?? 'Loading...'}', // Display "Loading..." if value is null
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
