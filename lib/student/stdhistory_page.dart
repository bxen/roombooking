import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    objective: 'Presentation practice',
                    status: 'Completed',
                  ),
                  const SizedBox(height: 10),
                  _buildHistoryCard(
                    room: 'C101',
                    date: '20 Oct 2025',
                    time: '08:00 - 10:00',
                    borrower: 'Lionflower',
                    approver: 'Dr. Krit',
                    objective: 'Meeting',
                    status: 'Canceled',
                  ), const SizedBox(height: 10),
                  _buildHistoryCard(
                    room: 'C101',
                    date: '20 Oct 2025',
                    time: '08:00 - 10:00',
                    borrower: 'Lionflower',
                    approver: 'Dr. Krit',
                    objective: 'Meeting',
                    status: 'Reject',
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
    required String objective,
    required String status,
  }) {
    
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'Completed':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'Canceled':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.orange;
        statusIcon = Icons.hourglass_bottom;
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFDFCFB),
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: statusColor, width: 6),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            children: [
              Icon(statusIcon, color: statusColor, size: 22),
              const SizedBox(width: 8),
              Text(
                'Room : $room',
                style: GoogleFonts.alice(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF161616),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildInfo('Date', date),
          _buildInfo('Time', time),
          _buildInfo('Borrower', borrower),
          _buildInfo('Approver', approver),
          _buildInfo('Objective', objective),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Status: $status',
              style: GoogleFonts.alice(
                color: statusColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
          fontSize: 16,
          height: 1.3,
        ),
      ),
    );
  }
}
