import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';
import 'lecturer_booking_history_detail_page.dart';

class LecturerBookingHistoryListPage extends StatelessWidget {
  const LecturerBookingHistoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: LecturerTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking History'),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
              onPressed: () => _showLogoutDialog(context),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            LecturerHistoryLine(
              title: 'Room C102',
              date: '20 Oct 2025',
              time: '10:00-12:00',
              status: 'Approved',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LecturerBookingHistoryDetailPage()),
              ),
            ),
            const SizedBox(height: 12),
            LecturerHistoryLine(
              title: 'Room C101',
              date: '22 Oct 2025',
              time: '13:00-14:00',
              status: 'Rejected',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LecturerBookingHistoryDetailPage()),
              ),
            ),
          ],
        ),
        bottomNavigationBar: lecturerBottomBar(context, 3),
      ),
    );
  }

  // ========= Beautiful Logout Dialog (เหมือนหน้าที่แล้ว) =========
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
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.alice(fontSize: 15, color: Colors.black),
                          ),
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
                          child: Text(
                            'Logout',
                            style: GoogleFonts.alice(fontSize: 15, color: Colors.white),
                          ),
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
}
