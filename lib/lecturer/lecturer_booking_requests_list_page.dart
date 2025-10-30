import 'package:flutter/material.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';
import 'lecturer_request_detail_main_page.dart';
import 'lecturer_request_detail_approve_page.dart';
import 'lecturer_request_detail_reject_page.dart';

class LecturerBookingRequestsListPage extends StatelessWidget {
  const LecturerBookingRequestsListPage({super.key});

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
            LecturerRequestCard(
              room: 'Room A307',
              date: '20 Oct 2025',
              time: '11:00-13:00',
              borrower: 'ID: 65070001',
              objective: 'Midterm practice',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LecturerRequestDetailMainPage()),
              ),
              actions: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LecturerRequestDetailApprovePage()),
                    ),
                    child: const Text('Approve'),
                  ),
                ),
                const SizedBox(width: 8),
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
            const SizedBox(height: 12),
            LecturerRequestCard(
              room: 'Room C101',
              date: '21 Oct 2025',
              time: '09:00-10:00',
              borrower: 'ID: 65070099',
              objective: 'Lab review',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LecturerRequestDetailMainPage()),
              ),
              actions: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LecturerRequestDetailApprovePage()),
                    ),
                    child: const Text('Approve'),
                  ),
                ),
                const SizedBox(width: 8),
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
