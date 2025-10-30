import 'package:flutter/material.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';

class LecturerBookingHistoryDetailPage extends StatelessWidget {
  const LecturerBookingHistoryDetailPage({super.key});

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
          children: const [
            LecturerRequestCard(
              room: 'Room C102',
              date: '20 Oct 2025',
              time: '10:00-12:00',
              borrower: 'User: 65070123',
              objective: 'Presentation practice',
            ),
          ],
        ),
        bottomNavigationBar: lecturerBottomBar(context, 3),
      ),
    );
  }
}
