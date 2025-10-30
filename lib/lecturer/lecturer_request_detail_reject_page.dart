import 'package:flutter/material.dart';
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
                      decoration: const InputDecoration(hintText: 'Optional reason'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () => Navigator.pop(context),
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
