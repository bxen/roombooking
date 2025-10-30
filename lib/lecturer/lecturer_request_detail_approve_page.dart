import 'package:flutter/material.dart';
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
              onPressed: () => showLecturerLogoutDialog(context),
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
        bottomNavigationBar: _bottom(context),
      ),
    );
  }

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
