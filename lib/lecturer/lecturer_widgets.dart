import 'package:flutter/material.dart';
import 'lecturer_theme.dart';
import 'lecturer_home.dart';
import 'lecturer_browse_rooms_page.dart';
import 'lecturer_booking_requests_list_page.dart';
import 'lecturer_booking_history_list_page.dart';
import '../screens/home_screen.dart';
class LecturerRoomCard extends StatelessWidget {
  const LecturerRoomCard({
    super.key,
    required this.roomName,
    required this.time,
    required this.status,
  });

  final String roomName;
  final String time;
  final String status;

  @override
  Widget build(BuildContext context) {
    final Color badge = switch (status) {
      'Free' => Colors.green,
      'Pending' => Colors.orange,
      _ => Colors.grey,
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: LecturerTheme.text,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(time, style: const TextStyle(color: LecturerTheme.text)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: badge.withOpacity(.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: badge),
              ),
              child: Text(
                status,
                style: TextStyle(color: badge, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LecturerRequestCard extends StatelessWidget {
  const LecturerRequestCard({
    super.key,
    required this.room,
    required this.date,
    required this.time,
    required this.borrower,
    required this.objective,
    this.onTap,
    this.actions,
  });

  final String room, date, time, borrower, objective;
  final VoidCallback? onTap;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(LecturerTheme.radius),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _row('Room', room),
              _row('Date', date),
              _row('Time', time),
              _row('Borrower', borrower),
              _row('Objective', objective),
              if (actions != null) ...[
                const SizedBox(height: 12),
                Row(children: actions!),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            SizedBox(width: 88, child: Text('$label:', style: const TextStyle(color: LecturerTheme.text))),
            Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600, color: LecturerTheme.text))),
          ],
        ),
      );
}

class LecturerHistoryLine extends StatelessWidget {
  const LecturerHistoryLine({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
    this.onTap,
  });

  final String title, date, time, status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final badge = status == 'Approved'
        ? Colors.green
        : status == 'Rejected'
            ? Colors.red
            : Colors.grey;

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: LecturerTheme.text)),
        subtitle: Text('$date  •  $time', style: const TextStyle(color: LecturerTheme.text)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: badge.withOpacity(.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: badge),
          ),
          child: Text(status, style: TextStyle(color: badge, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

/// Bottom bar — ใช้ pushReplacement ไปยังหน้าเพื่อนบ้าน (ไม่ยุ่งกับ main.dart)
BottomNavigationBar lecturerBottomBar(BuildContext context, int index) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: const Color(0xFF600000),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
    currentIndex: index,
    onTap: (i) {
      if (i == index) return;
      late final Widget page;
      switch (i) {
        case 0:
          page = const LecturerHome();
          break;
        case 1:
          page = const LecturerBrowseRoomsPage();
          break;
        case 2:
          page = const LecturerBookingRequestsListPage();
          break;
        case 3:
        default:
          page = const LecturerBookingHistoryListPage();
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => page),
      );
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: 'Rooms'),
      // Student ใช้ "Status" แต่ฝั่ง Lecturer คือ "Request"
      BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Request'),
      BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: 'History'),
    ],
  );
}
Widget lecturerProfileButton(BuildContext context) {
  return IconButton(
    icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text(
              'Are you sure you \nwant to logout?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Alice',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const StadiumBorder(),
                ),
                child: const Text('Logout',
                    style: TextStyle(
                        color: Colors.white, fontSize: 15, fontFamily: 'Alice')),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel',
                    style: TextStyle(
                        color: Colors.black, fontSize: 15, fontFamily: 'Alice')),
              ),
            ],
          );
        },
      );
    },
  );
}