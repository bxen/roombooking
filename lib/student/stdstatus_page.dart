import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/student/student_home.dart';
import 'package:roombooking/student/widgets/student_navbar.dart';

class StdstatusPage extends StatelessWidget {
  const StdstatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF6F0000),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- APP BAR ----------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: StudentNavbar(
                showBack: true,
                title: 'Booking Status',
                profileIconSize: 28,
              ),
            ),

            // ---------- BODY ----------
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildBookingCard(
                    context,
                    imagePath: 'images/roomA101.jpg',
                    room: 'A101',
                    date: '20 Oct 2025',
                    time: '10:00 - 12:00',
                    status: 'Approved',
                    objective: 'Presentation practice',
                  ),
                  const SizedBox(height: 16),
                  _buildBookingCard(
                    context,
                    imagePath: 'images/roomC101.jpg',
                    room: 'C101',
                    date: '21 Oct 2025',
                    time: '08:00 - 10:00',
                    status: 'Pending',
                    objective: 'Meeting',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Booking Card ----------
  static Widget _buildBookingCard(
    BuildContext context, {
    required String imagePath,
    required String room,
    required String date,
    required String time,
    required String status,
    required String objective,
  }) {
    final statusInfo = _getStatusInfo(status);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFF2F1ED),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- Image ----------
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),

            // ---------- Info ----------
            _buildInfo('Room', room),
            _buildInfo('Date', date),
            _buildInfo('Time', time),
            _buildInfo('Objective', objective),
            const SizedBox(height: 12),

            // ---------- Status & Button ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: statusInfo.color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.alice(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                _buildActionButton(context, status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Info Text ----------
  static Widget _buildInfo(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        '$label : $value',
        style: GoogleFonts.alice(
          color: color ?? const Color(0xFF161616),
          fontSize: 16,
          height: 1.3,
        ),
      ),
    );
  }

  // ---------- Action Button ----------
  static Widget _buildActionButton(BuildContext context, String status) {
    switch (status) {
      case 'Pending':
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size(100, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => _showConfirmDialog(context),
          child: Text(
            'Cancel',
            style: GoogleFonts.alice(color: Colors.black, fontSize: 16),
          ),
        );
      case 'Approved':
        return ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size(100, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Cancel',
            style: GoogleFonts.alice(color: Colors.grey, fontSize: 16),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  // ---------- Status Info ----------
  static _StatusInfo _getStatusInfo(String status) {
    switch (status) {
      case 'Pending':
        return _StatusInfo(color: Colors.yellow);
      case 'Reject':
        return _StatusInfo(color: Colors.red);
      case 'Approved':
        return _StatusInfo(color: Colors.blue);
      default:
        return _StatusInfo(color: Colors.grey);
    }
  }

  // ---------- Confirm Dialog ----------
  static void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Are you sure you \nwant to cancel this booking?',
          textAlign: TextAlign.center,
          style: GoogleFonts.alice(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Text(
          'This action cannot be undone.',
          textAlign: TextAlign.center,
          style: GoogleFonts.alice(color: Colors.red, fontSize: 16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const StudentHome(initialIndex: 3),
                ),
                (route) => false,
              );
            },
            child: Text(
              'Confirm',
              style: GoogleFonts.alice(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.alice(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Helper Class ----------
class _StatusInfo {
  final Color color;
  _StatusInfo({required this.color});
}
