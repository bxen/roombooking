import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffAddroom extends StatefulWidget {
  const StaffAddroom({super.key});

  @override
  State<StaffAddroom> createState() => _StaffAddroomState();
}

class _StaffAddroomState extends State<StaffAddroom> {
  bool isEnabled = true;
  List<String> selectedSlots = [];
  final TextEditingController roomNameController = TextEditingController();

  final List<String> timeSlots = [
    '8:00–10:00',
    '10:00–12:00',
    '13:00–15:00',
    '15:00–17:00',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5C0000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C0000),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add new room',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(20),
          ),

          // ✅ ห่อ Column ด้วย SingleChildScrollView
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Room name
                Text(
                  'Room name',
                  style: GoogleFonts.playfairDisplay(fontSize: 18),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: roomNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 14, 13, 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Status
                Row(
                  children: [
                    Text(
                      'Status: ',
                      style: GoogleFonts.playfairDisplay(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Enable',
                      style: GoogleFonts.playfairDisplay(fontSize: 16),
                    ),
                    Switch(
                      value: isEnabled,
                      activeColor: Colors.black,
                      onChanged: (value) => setState(() => isEnabled = value),
                    ),
                    Text(
                      'Disable',
                      style: GoogleFonts.playfairDisplay(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Room image placeholder + button
                Text(
                  'Room image',
                  style: GoogleFonts.playfairDisplay(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Update image',
                        style: GoogleFonts.playfairDisplay(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Time Slots
                Text(
                  'Default Time Slots:',
                  style: GoogleFonts.playfairDisplay(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Column(
                  children: timeSlots.map((slot) {
                    return CheckboxListTile(
                      title: Text(
                        slot,
                        style: GoogleFonts.playfairDisplay(fontSize: 16),
                      ),
                      activeColor: Colors.black,
                      value: selectedSlots.contains(slot),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedSlots.add(slot);
                          } else {
                            selectedSlots.remove(slot);
                          }
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // Save / Cancel buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: GoogleFonts.playfairDisplay(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.playfairDisplay(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
