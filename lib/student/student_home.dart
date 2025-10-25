// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:roombooking/student/stdroomlist.dart';

// class StudentHome extends StatefulWidget {
//   const StudentHome({super.key});

//   @override
//   State<StudentHome> createState() => _StudentHomeState();
// }

// class _StudentHomeState extends State<StudentHome> {
//   //image in the middle
//   Widget _buildRoomBox(String imagePath) {
//     return Container(
//       width: 130,
//       height: 130,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: Colors.white,
//         image: DecorationImage(
//           image: AssetImage(imagePath), // ดึงรูปจาก assets
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Welcome!',
//           style: GoogleFonts.alice(color: Colors.white, fontSize: 30),
//         ),
//         backgroundColor: Color(0xFF630000),
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(vertical: 10),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Text(
//               'Rule for using Room Reservation\n\n'
//               '-Students can book only for today.\n'
//               '-Each student can book only one time slot per day.\n'
//               '-Past time slots are not available for booking.',
//               style: GoogleFonts.alice(
//                 color: Colors.white,
//                 fontSize: 16,
//                 height: 1.6,
//               ),
//             ),
//           ),
//           //image in the middle
//           const SizedBox(height: 40),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildRoomBox('images/roomA101.jpg'),
//               _buildRoomBox('images/roomC103.jpg'),
//             ],
//           ),

//           Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//                children: [
//                   Text(
//                     "Let make a \nReservation",
//                     style: GoogleFonts.alice(color: Colors.white, fontSize: 18),
//                   ),
//                   const SizedBox(width: 12),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const Stdroomlist()),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       shape: const CircleBorder(),
//                       backgroundColor: Colors.white,
//                     ),
//                     child: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black),
//                   ),
//                 ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';
import 'package:roombooking/student/stdhistory_page.dart';
import 'package:roombooking/student/stdroomlist.dart';
import 'package:roombooking/student/stdstatus_page.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const StudentHomePage(),
    const Stdroomlist(), // browse room list page
    const StdhistoryPage(), // history page
    const StdstatusPage(), // status page
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
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Status'),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_edu),
            label: 'History',
          ),
        ],
      ),
    );
  }
}

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

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
                              child: Text('Logout',style: GoogleFonts.alice(color: Colors.white,fontSize: 15),),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                               style: GoogleFonts.alice(color: Colors.black,fontSize: 15),
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
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Rule for using Room Reservation\n\n'
                '• Students can book only for today.\n'
                '• Each student can book only one time slot per day.\n'
                '• Past time slots are not available for booking.',
                style: GoogleFonts.alice(
                  color: Colors.white,
                  fontSize: 17,
                  height: 1.6,
                ),
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
