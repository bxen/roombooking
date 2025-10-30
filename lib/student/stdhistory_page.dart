import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';
import 'package:roombooking/student/widgets/student_navbar.dart';

class StdhistoryPage extends StatelessWidget {
  const StdhistoryPage({super.key});

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
                title: 'Booking History',
                profileIconSize: 28,
              ),
            ),

            // ---------- BODY ----------
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildHistoryCard(
                    room: 'A207',
                    date: '20 Oct 2025',
                    time: '10:00 - 12:00',
                    borrower: 'Lionflower',
                    approver: 'Dr. Somchai',
                    status: 'Completed',
                    objective: 'Presentation practice',
                    note: 'Room used successfully',
                  ),
                  const SizedBox(height: 16),
                  _buildHistoryCard(
                    room: 'C101',
                    date: '20 Oct 2025',
                    time: '08:00 - 10:00',
                    borrower: 'Lionflower',
                    approver: 'Dr. Krit',
                    status: 'Canceled',
                    objective: 'Meeting',
                    note: 'Room unavailable',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- History Card ----------
  static Widget _buildHistoryCard({
    required String room,
    required String date,
    required String time,
    required String borrower,
    required String approver,
    required String status,
    required String objective,
    required String note,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFF2F1ED),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfo('Room', room),
            _buildInfo('Date', date),
            _buildInfo('Time', time),
            _buildInfo('Borrower', borrower),
            _buildInfo('Approver', approver),
            _buildInfo('Status', status),
            _buildInfo('Objective', objective),
            _buildInfo('Note', note, color: Colors.black87),
          ],
        ),
      ),
    );
  }

  static Widget _buildInfo(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        '$label : $value',
        style: GoogleFonts.alice(
          color: color ?? const Color(0xFF161616),
          fontSize: 15,
          height: 1.3,
        ),
      ),
    );
  }
}
