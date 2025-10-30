import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/lecturer/lecturer_home.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';

class LecturerBrowseRoomsPage extends StatelessWidget {
  const LecturerBrowseRoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = <_RoomData>[
      _RoomData('Room A101', 'images/roomA101.jpg', const [
        _Slot('8:00–10:00', 'Free', Colors.green),
        _Slot('10:00–12:00', 'Free', Colors.green),
        _Slot('13:00–15:00', 'Pending', Colors.orange),
        _Slot('15:00–17:00', 'Free', Colors.green),
      ]),
      _RoomData('Room A102', 'images/roomA102.jpg', const [
        _Slot('8:00–10:00', 'Free', Colors.green),
        _Slot('10:00–12:00', 'Disabled', Colors.red),
        _Slot('13:00–15:00', 'Pending', Colors.orange),
        _Slot('15:00–17:00', 'Free', Colors.green),
      ]),
      _RoomData('Room B201', 'images/roomB201.jpg', const [
        _Slot('8:00–10:00', 'Free', Colors.green),
        _Slot('10:00–12:00', 'Disabled', Colors.red),
        _Slot('13:00–15:00', 'Pending', Colors.orange),
        _Slot('15:00–17:00', 'Free', Colors.green),
      ]),
      _RoomData('Room B202', 'images/roomB202.jpg', const [
        _Slot('8:00–10:00', 'Free', Colors.green),
        _Slot('10:00–12:00', 'Disabled', Colors.red),
        _Slot('13:00–15:00', 'Pending', Colors.orange),
        _Slot('15:00–17:00', 'Free', Colors.green),
      ]),
      _RoomData('Room C101', 'images/roomC101.jpg', const [
        _Slot('8:00–10:00', 'Free', Colors.green),
        _Slot('10:00–12:00', 'Disabled', Colors.red),
        _Slot('13:00–15:00', 'Pending', Colors.orange),
        _Slot('15:00–17:00', 'Free', Colors.green),
      ]),
      _RoomData('Room C102', 'images/roomC102.jpg', const [
        _Slot('8:00–10:00', 'Free', Colors.green),
        _Slot('10:00–12:00', 'Disabled', Colors.red),
        _Slot('13:00–15:00', 'Pending', Colors.orange),
        _Slot('15:00–17:00', 'Free', Colors.green),
      ]),
      _RoomData('Room C103', 'images/roomC103.jpg', const [
        _Slot('8:00–10:00', 'Pending', Colors.orange),
        _Slot('10:00–12:00', 'Disable', Colors.red),
        _Slot('13:00–15:00', 'Pending', Colors.orange),
        _Slot('15:00–17:00', 'Disable', Colors.red),
      ]),
    ];

    final today = DateTime.now();
    final dateText =
        'Time Slots ${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year}';

    return Theme(
      data: LecturerTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>LecturerHome())),
          ),
          title: Text('Browse Rooms',
              style: GoogleFonts.alice(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle,
                  color: Colors.white, size: 32),
              onPressed: () => showLecturerLogoutDialog(context),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              itemCount: rooms.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (_, i) {
                final r = rooms[i];
                return _BrowseCard(
                  imagePath: r.imagePath,
                  roomName: r.name,
                  dateText: dateText,
                  slots: r.slots,
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: lecturerBottomBar(context, 1),
      ),
    );
  }
}

/// การ์ดใหญ่เหมือน student_browse แต่ตัดปุ่ม More ออก
class _BrowseCard extends StatelessWidget {
  const _BrowseCard({
    required this.imagePath,
    required this.roomName,
    required this.dateText,
    required this.slots,
  });

  final String imagePath;
  final String roomName;
  final String dateText;
  final List<_Slot> slots;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // รูปห้อง
          Container(
            width: 120,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // ข้อมูลห้อง
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomName,
                  style: GoogleFonts.alice(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  dateText,
                  style: GoogleFonts.alice(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: slots.map((s) {
                    final color = s.color;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        '${s.time}  ${s.status}',
                        style: GoogleFonts.alice(
                          color: color,
                          fontSize: 16,
                          height: 1.2,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomData {
  final String name;
  final String imagePath;
  final List<_Slot> slots;
  _RoomData(this.name, this.imagePath, this.slots);
}

class _Slot {
  final String time;
  final String status;
  final Color color;
  const _Slot(this.time, this.status, this.color);
}
