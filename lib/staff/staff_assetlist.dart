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
      backgroundColor: const Color(0xFF5E0B06), // สีแดงเข้มด้านหลัง
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // แถบด้านบน
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // รายการห้อง
              Expanded(
                child: ListView(
                  children: [
                    _buildRoomCard(
                      imagePath: 'images/roomA101.jpg',
                      roomName: 'Room A207',
                      date: '20 Oct 2025',
                      timeSlots: [
                        {'time': '8:00–10:00', 'status': 'Free'},
                        {'time': '10:00–12:00', 'status': 'Free'},
                        {'time': '13:00–15:00', 'status': 'Pending'},
                        {'time': '15:00–17:00', 'status': 'Free'},
                      ],
                    ),
                    _buildRoomCard(
                      imagePath: 'images/roomB109.jpg',
                      roomName: 'Room B109',
                      date: '20 Oct 2025',
                      timeSlots: [
                        {'time': '8:00–10:00', 'status': 'Free'},
                        {'time': '10:00–12:00', 'status': 'Free'},
                        {'time': '13:00–15:00', 'status': 'Pending'},
                        {'time': '15:00–17:00', 'status': 'Disable'},
                      ],
                    ),
                    _buildRoomCard(
                      imagePath: 'images/roomC101.jpg',
                      roomName: 'Room C101',
                      date: '20 Oct 2025',
                      timeSlots: [
                        {'time': '8:00–10:00', 'status': 'Pending'},
                        {'time': '10:00–12:00', 'status': 'Disable'},
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
    required String date,
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
          // รูปภาพห้อง
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // ข้อมูลห้อง
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
                  'Time Slots $date',
                  style: GoogleFonts.alice(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
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
                      case 'Disable':
                        color = Colors.red;
                        break;
                      case 'Reserved':
                        color = Colors.blue;
                        break;
                      default:
                        color = Colors.black;
                    }
                    return Text(
                      '${slot['time']}   ${slot['status']}',
                      style: GoogleFonts.alice(fontSize: 16, color: color),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),

                // ปุ่ม Edit + Disable
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showEditDialog(context, roomName);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        'EDIT',
                        style: GoogleFonts.alice(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        'Disable',
                        style: GoogleFonts.alice(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, String roomName) {
    TextEditingController nameController = TextEditingController(
      text: roomName,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(
            child: Text(
              'EDIT',
              style: GoogleFonts.alice(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Change Name',
                      style: GoogleFonts.alice(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Change Image',
                      style: GoogleFonts.alice(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Save',
                      style: GoogleFonts.alice(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.alice(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
              onPressed: () {
                Navigator.pop(context);
              },
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
