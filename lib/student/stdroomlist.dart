import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:roombooking/student/stdbooking_page.dart';
import 'package:roombooking/student/widgets/student_navbar.dart';
import 'package:roombooking/services/api_client.dart';
import 'package:roombooking/services/session.dart';

class Stdroomlist extends StatefulWidget {
  const Stdroomlist({super.key});

  @override
  State<Stdroomlist> createState() => _StdroomlistState();
}

class _StdroomlistState extends State<Stdroomlist> {
  late Future<List<Map<String, dynamic>>> _rooms;

  @override
  void initState() {
    super.initState();
    _rooms = _fetchRoomsToday();
  }

  Future<List<Map<String, dynamic>>> _fetchRoomsToday() async {
    // ✅ ไม่ต้องส่ง user_id แล้ว ให้ backend ใช้ session แทน
    final res = await api.get(
      '/api/student/rooms/today',
      // ไม่ต้องมี query ก็ได้ เพราะ api_client ใส่ '_' cache-buster ให้เองอยู่แล้ว
    ) as List<dynamic>;
    return res.cast<Map<String, dynamic>>();
  }

  bool _isPastSlot(String startHHmm) {
    final now = DateTime.now();
    final parts = startHHmm.split(':');
    final start = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
    return now.isAfter(start);
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('d/M/yyyy').format(DateTime.now());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StudentNavbar(showBack: true),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
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
                    final data = snap.data ?? [];
                    if (data.isEmpty) {
                      return const Center(
                        child: Text(
                          'No rooms.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, i) {
                        final r = data[i];
                        final roomId = (r['room_id'] as num).toInt();
                        final roomName = r['room_name'] as String;
                        final roomStatus =
                            r['room_status'] as String; // free|disabled
                        final img = r['image_url'] as String?;
                        final alreadyBooked =
                            r['user_already_booked_today'] == true;

                        final slots = (r['time_slots'] as List)
                            .cast<Map<String, dynamic>>()
                            // กรองสลอตที่เลยเวลาปัจจุบันแล้วออก (ตาม requirement)
                            .where((s) => !_isPastSlot(
                                (s['start'] as String).substring(0, 5)))
                            .toList();

                        final hasFree = roomStatus == 'free' &&
                            !alreadyBooked &&
                            slots.any((s) => s['status'] == 'free');

                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.only(bottom: 20),
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
                                  image: img != null
                                      ? DecorationImage(
                                          image: AssetImage(img),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                                child: img == null
                                    ? const Icon(Icons.image, size: 40)
                                    : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            roomName,
                                            style: GoogleFonts.alice(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: roomStatus == 'free'
                                                ? Colors.green[100]
                                                : Colors.red[100],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            roomStatus.toUpperCase(),
                                            style: GoogleFonts.alice(
                                              color: roomStatus == 'free'
                                                  ? Colors.green[900]
                                                  : Colors.red[900],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Time Slots $today',
                                      style: GoogleFonts.alice(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        height: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: slots.map((s) {
                                        final start = (s['start'] as String)
                                            .substring(0, 5);
                                        final end = (s['end'] as String)
                                            .substring(0, 5);
                                        final status =
                                            s['status'] as String; // free/pending/reserved/disabled
                                        Color color;
                                        switch (status) {
                                          case 'free':
                                            color = Colors.green[800]!;
                                            break;
                                          case 'pending':
                                            color = Colors.amber[800]!;
                                            break;
                                          case 'reserved':
                                            color = Colors.blueGrey[800]!;
                                            break;
                                          case 'disabled':
                                            color = Colors.red;
                                            break;
                                          default:
                                            color = Colors.black;
                                        }
                                        return Text(
                                          '$start–$end  $status',
                                          style: GoogleFonts.alice(
                                            color: color,
                                            fontSize: 16,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: ElevatedButton(
                                        onPressed: hasFree
                                            ? () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        StdbookingPage(
                                                      roomId: roomId,
                                                      roomName: roomName,
                                                      roomStatus: roomStatus,
                                                      imagePath: img,
                                                      timeSlots:
                                                          slots, // ส่ง list ของ slot object เลย
                                                      userAlreadyBookedToday:
                                                          alreadyBooked,
                                                    ),
                                                  ),
                                                ).then(
                                                  (_) => setState(() {
                                                    _rooms =
                                                        _fetchRoomsToday();
                                                  }),
                                                );
                                              }
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          shape: const StadiumBorder(),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 6,
                                          ),
                                        ),
                                        child: Text(
                                          'More',
                                          style: GoogleFonts.alice(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
