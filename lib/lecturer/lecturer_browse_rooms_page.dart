import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:roombooking/lecturer/lecturer_home.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';
import '../services/api_client.dart';

class LecturerBrowseRoomsPage extends StatefulWidget {
  const LecturerBrowseRoomsPage({super.key});
  @override
  State<LecturerBrowseRoomsPage> createState() =>
      _LecturerBrowseRoomsPageState();
}

class _LecturerBrowseRoomsPageState extends State<LecturerBrowseRoomsPage> {
  late Future<List<_RoomData>> _rooms;
  final String _date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _rooms = _fetch();
  }

  Future<List<_RoomData>> _fetch() async {
    final rows =
        await api.get(
              '/api/rooms',
              query: {
                'date': _date,
                '_': DateTime.now().millisecondsSinceEpoch, // cache-buster
              },
            )
            as List<dynamic>;
    return rows.map((r) {
      final image =
          (r as Map<String, dynamic>)['image_url'] as String? ??
          'images/roomA101.jpg';
      final name = r['room_name'] as String? ?? '-';
      final ts =
          (r['timeslots'] as List<dynamic>? ?? const [])
              .cast<Map<String, dynamic>>()
              .map((t) {
                final s = (t['status'] as String? ?? 'free').toLowerCase();
                Color c;
                switch (s) {
                  case 'pending':
                    c = Colors.orange;
                    break;
                  case 'disabled':
                    c = Colors.red;
                    break;
                  case 'reserved':
                    c = Colors.blue;
                    break; // โชว์เหมือน “Reserved” เป็นเขียวตาม UI เดิม
                  default:
                    c = Colors.green;
                }
                final start = (t['start_time'] as String).substring(0, 5);
                final end = (t['end_time'] as String).substring(0, 5);
                final label = s == 'reserved'
                    ? 'Reserved'
                    : (s[0].toUpperCase() + s.substring(1));
                return _Slot('$start–$end', label, c);
              })
              .toList()
            ..sort((a, b) => a.time.compareTo(b.time));
      return _RoomData(name, image, ts);
    }).toList();
  }

  Future<void> _refresh() async {
    setState(() {
      _rooms = _fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dateText =
        'Time Slots ${today.day.toString().padLeft(2, '0')}/${today.month.toString().padLeft(2, '0')}/${today.year}';

    return Theme(
      data: LecturerTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LecturerHome()),
            ),
          ),
          title: Text(
            'Browse Rooms',
            style: GoogleFonts.alice(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () => showLecturerLogoutDialog(context),
            ),
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: FutureBuilder<List<_RoomData>>(
              future: _rooms,
              builder: (_, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snap.error}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                final rooms = snap.data ?? const <_RoomData>[];
                if (rooms.isEmpty) {
                  return Center(
                    child: Text(
                      'No rooms',
                      style: GoogleFonts.alice(color: Colors.white),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
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

/// การ์ดใหญ่เหมือนเดิม
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
                  children: slots
                      .map(
                        (s) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            '${s.time}  ${s.status}',
                            style: GoogleFonts.alice(
                              color: s.color,
                              fontSize: 16,
                              height: 1.2,
                            ),
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
