import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';
import 'package:roombooking/student/stdbooking_page.dart';

class Stdroomlist extends StatefulWidget {
  const Stdroomlist({super.key});

  @override
  State<Stdroomlist> createState() => _StdroomlistState();
}

class _StdroomlistState extends State<Stdroomlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  //profile
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () {
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
                              style: GoogleFonts.alice(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const HomeScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: const StadiumBorder(),
                                ),
                                child: Text(
                                  'Logout',
                                  style: GoogleFonts.alice(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.alice(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
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
    required imagePath,
    required roomName,
    required date,
    required List<Map<String, String>> timeSlots,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Text(
                  roomName,
                  style: GoogleFonts.alice(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Time Slots ${date.day}/${date.month}/${date.year}',
                  style: GoogleFonts.alice(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: timeSlots.map((slot) {
                    final color = slot['status'] == 'Free'
                        ? Colors.green[800]
                        : slot['status'] == 'Pending'
                        ? Colors.amber[800]
                        : Colors.red;
                    return Text(
                      '${slot['time']}  ${slot['status']}',
                      style: GoogleFonts.alice(color: color, fontSize: 16),
                    );
                  }).toList(),
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StdbookingPage(
                            roomName: roomName,
                            status: 'free',
                            imagePath: imagePath,
                            timeSlots: [
                              '8:00–10:00',
                              '10:00–12:00',
                              '13:00–15:00',
                              '15:00–17:00',
                            ],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 6,
                      ),
                    ),
                    child: Text(
                      'More',
                      style: GoogleFonts.alice(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
