import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';

class LecturerBrowseRoomsPage extends StatelessWidget {
  const LecturerBrowseRoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: LecturerTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const SizedBox.shrink(),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
              onPressed: () => _showLogoutDialog(context),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          children: const [
            _RoomItem(
              room: 'Room A207',
              dateText: 'Time Slots 20 Oct2025',
              imagePath: 'images/roomA101.jpg',
              slots: [
                _Slot('8:00–10:00', 'Free', Colors.green),
                _Slot('10:00–12:00', 'Free', Colors.green),
                _Slot('13:00–15:00', 'Pending', Colors.orange),
                _Slot('15:00–17:00', 'Free', Colors.green),
              ],
            ),
            SizedBox(height: 12),
            _RoomItem(
              room: 'Room B109',
              dateText: 'Time Slots 20 Oct2025',
              imagePath: 'images/roomB201.jpg',
              slots: [
                _Slot('8:00–10:00', 'Free', Colors.green),
                _Slot('10:00–12:00', 'Disabled', Colors.red),
                _Slot('13:00–15:00', 'Pending', Colors.orange),
                _Slot('15:00–17:00', 'Disable', Colors.red),
              ],
            ),
            SizedBox(height: 12),
            _RoomItem(
              room: 'Room C101',
              dateText: 'Time Slots 20 Oct2025',
              imagePath: 'images/roomC101.jpg',
              slots: [
                _Slot('8:00–10:00', 'Pending', Colors.orange),
                _Slot('10:00–12:00', 'Disable', Colors.red),
                _Slot('13:00–15:00', 'Pending', Colors.orange),
                _Slot('15:00–17:00', 'Disable', Colors.red),
              ],
            ),
          ],
        ),
        bottomNavigationBar: lecturerBottomBar(context, 1),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: 'logout',
      barrierDismissible: true,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 320,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F1ED), shape: BoxShape.circle),
                    child: const Icon(Icons.logout, color: Colors.red, size: 28),
                  ),
                  const SizedBox(height: 12),
                  Text('Are you sure you\nwant to logout?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alice(
                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black, height: 1.2)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: const StadiumBorder(),
                          ),
                          child: Text('Cancel',
                              style: GoogleFonts.alice(fontSize: 15, color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: const StadiumBorder(),
                          ),
                          child: Text('Logout',
                              style: GoogleFonts.alice(fontSize: 15, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return Transform.scale(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(anim).value,
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    );
  }
}

// -------------------- การ์ดห้อง (responsive) --------------------

class _RoomItem extends StatelessWidget {
  const _RoomItem({
    required this.room,
    required this.dateText,
    required this.slots,
    required this.imagePath,
  });

  final String room;
  final String dateText;
  final List<_Slot> slots;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, c) {
        final cardW = c.maxWidth;
        final imageSize = (cardW * 0.23).clamp(80.0, 110.0);

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            constraints: const BoxConstraints(minHeight: 110), // กำหนดความสูงขั้นต่ำให้บาลานซ์
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // รูปอยู่กลางแนวตั้ง
              children: [
                // ==== รูปห้อง ====
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => Container(
                          color: Colors.black12,
                          alignment: Alignment.center,
                          child: const Icon(Icons.photo, color: Colors.black45, size: 22),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // ==== เนื้อหาด้านขวา ====
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              room,
                              style: const TextStyle(
                                color: LecturerTheme.text,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              dateText,
                              style: const TextStyle(
                                color: LecturerTheme.text,
                                fontSize: 13,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: slots
                            .map(
                              (s) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        s.time,
                                        style: const TextStyle(
                                          color: LecturerTheme.text,
                                          fontSize: 13,
                                          height: 1.1,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      s.status,
                                      style: TextStyle(
                                        color: s.color,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        height: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


class _Slot {
  final String time;
  final String status;
  final Color color;
  const _Slot(this.time, this.status, this.color);
}
