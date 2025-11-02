import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';
import 'package:roombooking/staff/staff_home.dart';
import 'package:roombooking/staff/widgets/staff_navbar.dart'; 

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>StaffHome())),
        ),
        title: Text('Manage Rooms', style: GoogleFonts.alice(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Expanded(
                child: ListView(
                  children: [
                  _buildRoomCard(
                      context: context, 
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
                      context: context,
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
                      context: context,
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
                      context: context,
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
                      context: context,
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
                      context: context,
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
    required BuildContext context,
    required String imagePath,
    required String roomName,
    required List<Map<String, String>> timeSlots, 
    required DateTime date, 
  }) {

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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  'Date: $formattedDate',
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
                      case 'Disabled': 
                        color = Colors.red;
                        break;
                      default:
                        color = Colors.black;
                    }
                    return Text(
                      '${slot['time']}  ${slot['status']}',
                      style: GoogleFonts.alice(fontSize: 16, color: color),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showEditDialog(context, roomName, imagePath);
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
                      onPressed: () {
                        _showDisableDialog(context, roomName);
                      },
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


  void _showEditDialog(BuildContext context, String roomName, String currentImagePath) {
    final TextEditingController nameController = TextEditingController(text: roomName);
    String? selectedImagePath = currentImagePath; 

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alice(color: Colors.black), 
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30), 
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80, 
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                            image: selectedImagePath != null
                              ? DecorationImage(
                                  image: AssetImage(selectedImagePath!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          ),
                          child: selectedImagePath == null 
                            ? Icon(Icons.image, size: 40, color: Colors.grey[600]) 
                            : null,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, 
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(horizontal: 16)
                          ),
                          onPressed: () {
                            setState(() {
                              selectedImagePath = 'images/roomA102.jpg'; 
                            });
                          },
                          child: Text(
                            'Upload Image',
                            style: GoogleFonts.alice(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                          ),
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: Text('Save', style: GoogleFonts.alice(color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                          ),
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Text('Cancel', style: GoogleFonts.alice(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  void _showDisableDialog(
    BuildContext context,
    String roomName,
  ) {
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
          content: Text(
            'Are you sure you want to disable $roomName?', // (แก้ไขข้อความ)
            textAlign: TextAlign.center,
            style: GoogleFonts.alice(fontSize: 16, color: Colors.red), // (สีแดง)
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey[400]!),
                shape: const StadiumBorder(),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.alice(color: Colors.black),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                
                _showSuccessDialog( 
                  context,
                  roomName,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[700], 
                shape: const StadiumBorder(),
              ),
              child: Text(
                'Confirm', // (แก้ไขข้อความ)
                style: GoogleFonts.alice(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(
    BuildContext context,
    String roomName,
  ) {
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
                "'$roomName'\nhas been disabled successfully.",
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

