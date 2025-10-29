import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';

class LecturerRequestDetailApprovePage extends StatelessWidget {
  const LecturerRequestDetailApprovePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: LecturerTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking Requests'),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
              onPressed: () => _showLogoutDialog(context),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            LecturerRequestCard(
              room: 'Room A307',
              date: '20 Oct 2025',
              time: '11:00-13:00',
              borrower: 'ID: 65070001',
              objective: 'Midterm practice',
            ),
            SizedBox(height: 12),
          ],
        ),
        // คง bottom bar ตามเดิม
        bottomNavigationBar: _bottom(context),
      ),
    );
  }

  // ====== Beautiful Logout Dialog (เหมือนหน้าก่อน) ======
  void _showLogoutDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: 'logout',
      barrierDismissible: true,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 320,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F1ED),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.logout, color: Colors.red, size: 28),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Are you sure you\nwant to logout?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alice(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: const StadiumBorder(),
                          ),
                          child: Text('Cancel',
                              style: GoogleFonts.alice(fontSize: 15, color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: const StadiumBorder(),
                          ),
                          child: Text('Logout',
                              style: GoogleFonts.alice(fontSize: 15, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return Transform.scale(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(anim).value,
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    );
  }

  // ====== ส่วน bottom ที่คุณทำไว้เดิม (การ์ดแจ้ง approved + ปุ่ม Back + bottom bar) ======
  Widget _bottom(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Booking Approved',
                    style: TextStyle(fontWeight: FontWeight.w700, color: LecturerTheme.text)),
                SizedBox(height: 8),
                Text('The booking has been approved successfully.',
                    style: TextStyle(color: LecturerTheme.text)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back'),
          ),
        ),
        lecturerBottomBar(context, 2),
      ],
    );
  }
}
