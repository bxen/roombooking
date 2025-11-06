import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/student/widgets/student_navbar.dart';
import 'package:roombooking/student/student_home.dart';
import 'package:roombooking/services/api_client.dart';
import 'package:roombooking/services/session.dart';

class StdstatusPage extends StatefulWidget {
  const StdstatusPage({super.key});

  @override
  State<StdstatusPage> createState() => _StdstatusPageState();
}

class _StdstatusPageState extends State<StdstatusPage> {
  late Future<List<Map<String, dynamic>>> _pending;
  void _refreshNow() {
    setState(() {
      // <-- ใช้บล็อค
      _pending = _fetchPending();
    });
  }

  @override
  void initState() {
    super.initState();
    _pending = _fetchPending();
  }

  Future<List<Map<String, dynamic>>> _fetchPending() async {
    final res =
        await api.get(
              '/api/student/bookings',
              query: {'scope': 'pending', 'user_id': Session.userId},
            )
            as List<dynamic>;
    return res.cast<Map<String, dynamic>>();
  }

  Future<void> _refresh() async {
    if (!mounted) return;
    setState(() {
      // <-- ใช้บล็อค
      _pending = _fetchPending();
    });
    // ไม่แตะ UI เพิ่มเติม ให้ FutureBuilder ได้ future ใหม่แล้วรีเพนต์เอง
  }

  Future<void> _cancel(int bookingId) async {
    try {
      await api.post(
        '/api/bookings/$bookingId/cancel',
        body: {'user_id': Session.userId},
      );
      if (!mounted) return;
      _refreshNow(); // รีเฟรชทันที
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking cancelled', style: GoogleFonts.alice()),
        ),
      );
    } catch (e) {
      final msg = e.toString();
      // เซิร์ฟเวอร์ส่งเป็นข้อความธรรมดา -> ถือว่าสำเร็จ
      if (msg.contains('FormatException') ||
          msg.contains('Unexpected character')) {
        if (!mounted) return;
        _refreshNow();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking cancelled', style: GoogleFonts.alice()),
          ),
        );
        return;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Cancel failed: $e',
              style: GoogleFonts.alice(color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF6F0000),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: StudentNavbar(
                showBack: true,
                title: 'Booking Status',
                profileIconSize: 28,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _pending,
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
                  final list = snap.data ?? [];
                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No pending bookings.',
                            style: GoogleFonts.alice(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {
                              final home = context
                                  .findAncestorStateOfType<StudentHomeState>();
                              if (home != null) home.changeTab(1);
                            },
                            child: Text(
                              'Book a room',
                              style: GoogleFonts.alice(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: list.length,
                    itemBuilder: (_, i) {
                      final b = list[i];
                      final id = (b['booking_id'] as num).toInt();
                      final img = b['image_url'] as String?;
                      final room = b['room_name'] as String;
                      final date = b['booking_date'] as String;
                      final start = (b['start_time'] as String).substring(0, 5);
                      final end = (b['end_time'] as String).substring(0, 5);
                      final objective = b['purpose'] as String? ?? '-';

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: const Color(0xFFF2F1ED),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: img == null
                                    ? const SizedBox.shrink()
                                    : Image.asset(
                                        img,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              const SizedBox(height: 10),
                              _info('Room', room),
                              _info('Date', date),
                              _info('Time', '$start - $end'),
                              _info('Objective', objective),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Pending',
                                      style: GoogleFonts.alice(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      minimumSize: const Size(100, 40),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () => _showConfirmDialog(
                                      context,
                                      () => _cancel(id),
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.alice(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
    );
  }

  Widget _info(String k, String v) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(
      '$k : $v',
      style: GoogleFonts.alice(color: const Color(0xFF161616), fontSize: 16),
    ),
  );

  void _showConfirmDialog(BuildContext context, Future<void> Function() run) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Are you sure you \nwant to cancel this booking?',
          textAlign: TextAlign.center,
          style: GoogleFonts.alice(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Text(
          'This action cannot be undone.',
          textAlign: TextAlign.center,
          style: GoogleFonts.alice(color: Colors.red, fontSize: 16),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
            onPressed: () async {
              Navigator.pop(ctx);
              await run(); // เรียก _cancel
              if (!mounted) return;
              _refreshNow(); // ย้ำอีกชั้นให้ FutureBuilder ได้ future ใหม่แน่ ๆ
            },
            child: Text(
              'Confirm',
              style: GoogleFonts.alice(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.alice(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
