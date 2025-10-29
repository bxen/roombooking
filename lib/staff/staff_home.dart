import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';
import 'package:roombooking/staff/staff_assetlist.dart';
import 'package:roombooking/student/stdhistory_page.dart';
import 'package:roombooking/student/stdroomlist.dart';
import 'package:roombooking/student/stdstatus_page.dart';

class StaffHome extends StatefulWidget {
  const StaffHome({super.key});

  @override
  State<StaffHome> createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const StaffHomePage(),
    const StaffAssetList(), // browse room list page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF600000),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room),
            label: 'Rooms',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_edu),
            label: 'History',
          ),
        ],
      ),
    );
  }
}

class StaffHomePage extends StatelessWidget {
  const StaffHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome !',
                  style: GoogleFonts.alice(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
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

            const SizedBox(height: 25),

            // 🔹 All Rooms Summary Box (เหมือนในรูป)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ALL ROOMS',
                    style: GoogleFonts.alice(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatusItem(Icons.meeting_room, 'Enable', '10'),
                      _buildStatusItem(Icons.meeting_room, 'Available', '7'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatusItem(Icons.meeting_room, 'Disable', '5'),
                      _buildStatusItem(Icons.meeting_room, 'Booked', '3'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildRoomBox('images/roomA101.jpg'),
                _buildRoomBox('images/roomC103.jpg'),
              ],
            ),
            const SizedBox(height: 50),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Let make a \nReservation",
                    style: GoogleFonts.alice(color: Colors.white, fontSize: 25),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Stdroomlist()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.white,
                    ),
                    child: const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomBox(String imagePath) {
    return Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(imagePath), // ดึงรูปจาก assets
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

Widget _buildStatusItem(IconData icon, String label, String number) {
  return Row(
    children: [
      Icon(icon, color: Colors.white, size: 18),
      const SizedBox(width: 8),
      Text(label, style: GoogleFonts.alice(color: Colors.white, fontSize: 15)),
      const SizedBox(width: 8),
      Text(
        number,
        style: GoogleFonts.alice(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
