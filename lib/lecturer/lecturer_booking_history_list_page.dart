import 'package:flutter/material.dart';
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
              onPressed: () => showLecturerLogoutDialog(context),
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
}
