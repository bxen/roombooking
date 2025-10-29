import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';

class StaffAssetList extends StatefulWidget {
  const StaffAssetList({super.key});

  @override
  State<StaffAssetList> createState() => _StaffAssetListState();
}

class _StaffAssetListState extends State<StaffAssetList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5E0B06),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () => _showLogoutDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: [
                    _buildRoomCard(
                      imagePath: 'images/roomA101.jpg',
                      roomName: 'Room A101',
                      date: DateTime.now(),
                      timeSlots: [
                        {'time': '8:00–10:00', 'status': 'Free'},
                        {'time': '10:00–12:00', 'status': 'Free'},
                        {'time': '13:00–15:00', 'status': 'Pending'},
                        {'time': '15:00–17:00', 'status': 'Free'},
                      ],
                    ),
                    _buildRoomCard(
                      imagePath: 'images/roomA102.jpg',
                      roomName: 'Room A102',
                      date: DateTime.now(),
                      timeSlots: [
                        {'time': '8:00–10:00', 'status': 'Free'},
                        {'time': '10:00–12:00', 'status': 'Disabled'},
                        {'time': '13:00–15:00', 'status': 'Pending'},
                        {'time': '15:00–17:00', 'status': 'Free'},
                      ],
                    ),
                    _buildRoomCard(
                      imagePath: 'images/roomB201.jpg',
                      roomName: 'Room B201',
                      date: DateTime.now(),
                      timeSlots: [
                        {'time': '8:00–10:00', 'status': 'Free'},
                        {'time': '10:00–12:00', 'status': 'Disabled'},
                        {'time': '13:00–15:00', 'status': 'Pending'},
                        {'time': '15:00–17:00', 'status': 'Free'},
                      ],
                    ),
                    _buildRoomCard(
                      imagePath: 'images/roomB202.jpg',
                      roomName: 'Room B202',
                      date: DateTime.now(),
                      timeSlots: [
                        {'time': '8:00–10:00', 'status': 'Free'},
                        {'time': '10:00–12:00', 'status': 'Disabled'},
                        {'time': '13:00–15:00', 'status': 'Pending'},
                        {'time': '15:00–17:00', 'status': 'Free'},
                      ],
                    ),
                    _buildRoomCard(
                      imagePath: 'images/roomC101.jpg',
                      roomName: 'Room C101',
                      date: DateTime.now(),
                      timeSlots: [
                        {'time': '8:00–10:00', 'status': 'Free'},
                        {'time': '10:00–12:00', 'status': 'Disabled'},
                        {'time': '13:00–15:00', 'status': 'Pending'},
                        {'time': '15:00–17:00', 'status': 'Free'},
                      ],
                    ),
                    _buildRoomCard(
                      imagePath: 'images/roomC102.jpg',
                      roomName: 'Room C102',
                      date: DateTime.now(),
                      timeSlots: [
                        {'time': '8:00–10:00', 'status': 'Free'},
                        {'time': '10:00–12:00', 'status': 'Disabled'},
                        {'time': '13:00–15:00', 'status': 'Pending'},
                        {'time': '15:00–17:00', 'status': 'Free'},
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomCard({
    required String imagePath,
    required String roomName,
    required DateTime date,
    required List<Map<String, String>> timeSlots,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // รูปภาพ
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              image: imagePath.isNotEmpty
                  ? DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: imagePath.isEmpty
                ? const Center(child: Icon(Icons.photo, color: Colors.white70))
                : null,
          ),
          const SizedBox(width: 16),

          // info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomName,
                  style: GoogleFonts.alice(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Time Slots ${date.toLocal()}',
                  style: GoogleFonts.alice(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // list times
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: timeSlots.map((slot) {
                    Color color;
                    switch (slot['status']) {
                      case 'Free':
                        color = Colors.green;
                        break;
                      case 'Pending':
                        color = Colors.amber[800]!;
                        break;
                      case 'Disabled':
                        color = Colors.red;
                        break;
                      default:
                        color = Colors.black;
                    }
                    return Text(
                      '${slot['time']}  ${slot['status']}',
                      style: GoogleFonts.alice(fontSize: 16, color: color),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Are you sure you \nwant to logout?',
            textAlign: TextAlign.center,
            style: GoogleFonts.alice(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const StadiumBorder(),
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.alice(color: Colors.white, fontSize: 15),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.alice(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        );
      },
    );
  }
}
