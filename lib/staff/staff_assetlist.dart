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

              // list view
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

  // ✅ แก้ชนิดข้อมูล date → DateTime
  Widget _buildRoomCard({
    required String imagePath,
    required String roomName,
    required DateTime date,
    required List<Map<String, String>> timeSlots,
  }) {
    // ✅ แปลงวันที่ให้อ่านง่าย
    String formattedDate = '${date.day}/${date.month}/${date.year}';

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
          // image
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
                  'Date: $formattedDate', // ✅ ใช้วันที่ที่ฟอร์แมตแล้ว
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
                      case 'Disabled': // ✅ ใช้ Disabled ให้ตรงกัน
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
                const SizedBox(height: 10),

                // buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showEditDialog(context, roomName),
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
                      onPressed: () =>
                          _showDisableDialog(context, roomName, timeSlots),
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

  // ----------- Edit Popup ----------
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
                  _dialogButton('Save Name', () {}),
                  _dialogButton('Save Image', () {}),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _dialogButton('Save', () => Navigator.pop(context)),
                  _dialogButton('Cancel', () => Navigator.pop(context)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ----------- Disable Popup ----------
  void _showDisableDialog(
    BuildContext context,
    String roomName,
    List<Map<String, String>> timeSlots,
  ) {
    List<bool> selected = List.filled(timeSlots.length, false);

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
              'Disable this room?',
              style: GoogleFonts.alice(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You are disabling $roomName for the following time slots:',
                    style: GoogleFonts.alice(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(timeSlots.length, (index) {
                      final slot = timeSlots[index];
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
                      return CheckboxListTile(
                        activeColor: Colors.black,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          '${slot['time']} ${slot['status']}',
                          style: GoogleFonts.alice(color: color),
                        ),
                        value: selected[index],
                        onChanged: (val) {
                          setState(() {
                            selected[index] = val!;
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'When disabled, this room will not be available for booking.',
                    style: GoogleFonts.alice(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          List<String> selectedTimes = [];
                          for (int i = 0; i < timeSlots.length; i++) {
                            if (selected[i]) {
                              selectedTimes.add(timeSlots[i]['time']!);
                            }
                          }

                          Navigator.pop(context);

                          if (selectedTimes.isNotEmpty) {
                            _showSuccessDialog(
                              context,
                              roomName,
                              selectedTimes,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[800],
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          'Confirm',
                          style: GoogleFonts.alice(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.alice(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // ✅ Popup success
  void _showSuccessDialog(
    BuildContext context,
    String roomName,
    List<String> selectedTimes,
  ) {
    String times = selectedTimes.join(', ');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(
            child: Icon(Icons.check_circle, color: Colors.green[700], size: 50),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "'$roomName'\nTime: $times\nhas been disabled successfully.",
                textAlign: TextAlign.center,
                style: GoogleFonts.alice(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  'OK',
                  style: GoogleFonts.alice(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper for dialog buttons
  Widget _dialogButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        shape: const StadiumBorder(),
      ),
      child: Text(text, style: GoogleFonts.alice(color: Colors.white)),
    );
  }

  // Logout dialog
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