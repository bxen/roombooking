import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart'; // ใช้กลับหน้า HomeScreen แบบ student
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';

class LecturerRequestDetailRejectPage extends StatelessWidget {
  const LecturerRequestDetailRejectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Theme(
      data: LecturerTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Requests'),
          actions: [
            // ปุ่มโปรไฟล์แบบเดียวกับหน้า Student
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
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
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: const StadiumBorder(),
                          ),
                          child: Text('Logout',
                              style: GoogleFonts.alice(color: Colors.white, fontSize: 15)),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: Text('Cancel',
                              style: GoogleFonts.alice(color: Colors.black, fontSize: 15)),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const LecturerRequestCard(
              room: 'Room A307',
              date: '20 Oct 2025',
              time: '11:00-13:00',
              borrower: 'ID: 65070001',
              objective: 'Midterm practice',
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Reject this booking?',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: LecturerTheme.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: controller,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Optional reason',
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        // ตอนนี้ให้ย้อนกลับไปหน้าก่อน (ตามเดิม)
                        // หากต้องการ popup "Booking Rejected" แบบหน้า Approve บอกผมได้ เดี๋ยวใส่ Stack+Overlay ให้
                        Navigator.pop(context);
                      },
                      child: const Text('Confirm Reject'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: lecturerBottomBar(context, 2),
      ),
    );
  }
}
