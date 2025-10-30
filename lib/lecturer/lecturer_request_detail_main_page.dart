import 'package:flutter/material.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';
import 'lecturer_request_detail_approve_page.dart';
import 'lecturer_request_detail_reject_page.dart';

class LecturerRequestDetailMainPage extends StatelessWidget {
  const LecturerRequestDetailMainPage({super.key});

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
              onPressed: () => showLecturerLogoutDialog(context),
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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LecturerRequestDetailApprovePage()),
                    ),
                    child: const Text('Approve'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LecturerRequestDetailRejectPage()),
                    ),
                    child: const Text('Reject'),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: lecturerBottomBar(context, 2),
      ),
    );
  }
}
