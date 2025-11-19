import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';
import '../services/api_client.dart';
import '../services/session.dart';
import 'package:intl/intl.dart';

class LecturerBookingRequestsListPage extends StatefulWidget {
  const LecturerBookingRequestsListPage({super.key});

  @override
  State<LecturerBookingRequestsListPage> createState() =>
      _LecturerBookingRequestsListPageState();
}

class _LecturerBookingRequestsListPageState
    extends State<LecturerBookingRequestsListPage> {
  late Future<List<Map<String, dynamic>>> _pending;

  void _refreshNow() {
    setState(() {
      _pending = _fetchPending();
    });
  }

  @override
  void initState() {
    super.initState();
    _pending = _fetchPending();
  }

  Future<List<Map<String, dynamic>>> _fetchPending() async {
    final data = await api.get(
      '/api/lecturer/requests',
      query: {
        '_': DateTime.now().millisecondsSinceEpoch, // cache-buster
      },
    ) as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }

  // ✅ ใช้ session ที่ backend แทน ไม่ต้องส่ง user_id แล้ว
  Future<void> _approve(int id) async {
    await api.post(
      '/api/lecturer/requests/$id/approve',
      // body: ไม่จำเป็นต้องมีอะไร ถ้า api_client บังคับก็ส่ง {} แทน
      body: const {},
    );
    if (!mounted) return;
    _refreshNow();
  }

  // ✅ ส่งแค่ reason ก็พอแล้ว user ผูกจาก session ฝั่ง server
  Future<void> _reject(int id, String reason) async {
    await api.post(
      '/api/lecturer/requests/$id/reject',
      body: {
        'reason': reason,
      },
    );
    if (!mounted) return;
    _refreshNow();
  }

  String formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString).toLocal();
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: LecturerTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Booking Requests', style: GoogleFonts.alice()),
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
        body: FutureBuilder<List<Map<String, dynamic>>>(
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
              return const Center(
                child: Text(
                  'No pending requests',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final r = list[i];
                final id = (r['booking_id'] as num).toInt();
                final room = r['room_name'] as String;
                final date = r['booking_date'] as String;
                final start = (r['start_time'] as String).substring(0, 5);
                final end = (r['end_time'] as String).substring(0, 5);
                final borrower = r['borrower'] as String? ?? '-';
                final purpose = r['purpose'] as String? ?? '-';

                return LecturerRequestCard(
                  room: room,
                  date: formatDate(date),
                  time: '$start-$end',
                  borrower: borrower,
                  objective: purpose,
                  actions: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            _confirmApprove(context, room, () => _approve(id)),
                        child: Text(
                          'Approve',
                          style: GoogleFonts.alice(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () => _confirmReject(
                          context,
                          room,
                          (reason) => _reject(id, reason),
                        ),
                        child: Text(
                          'Reject',
                          style: GoogleFonts.alice(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
        bottomNavigationBar: lecturerBottomBar(context, 2),
      ),
    );
  }

  void _confirmApprove(
    BuildContext context,
    String room,
    Future<void> Function() run,
  ) {
    showDialog(
      context: context,
      builder: (d) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle_outline, color: Colors.green.shade700),
            const SizedBox(width: 10),
            Text(
              'Confirm Approval',
              style: GoogleFonts.alice(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          'Do you want to approve the booking request for $room?',
          style: GoogleFonts.alice(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
            ),
            child: Text(
              'Approve',
              style: GoogleFonts.alice(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              Navigator.pop(d);
              await run();
              if (!mounted) return;
              _refreshNow();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green.shade700,
                  content: Text(
                    '$room has been approved!',
                    style: GoogleFonts.alice(color: Colors.white),
                  ),
                ),
              );
            },
          ),
          TextButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.alice(color: Colors.grey.shade700),
            ),
            onPressed: () => Navigator.pop(d),
          ),
        ],
      ),
    );
  }

  void _confirmReject(
    BuildContext context,
    String room,
    Future<void> Function(String reason) run,
  ) {
    final controller = TextEditingController();
    String? errorText;
    showDialog(
      context: context,
      builder: (d) => StatefulBuilder(
        builder: (c, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            title: Row(
              children: [
                Icon(Icons.cancel_outlined, color: Colors.red.shade700),
                const SizedBox(width: 10),
                Text(
                  'Confirm Rejection',
                  style: GoogleFonts.alice(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Do you want to reject the booking request for $room?',
                  style: GoogleFonts.alice(fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  autofocus: true,
                  style: GoogleFonts.alice(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Reason',
                    errorText: errorText,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                ),
                child: Text(
                  'Reject',
                  style: GoogleFonts.alice(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  final reason = controller.text.trim();
                  if (reason.isEmpty) {
                    setState(() => errorText = 'Please provide a reason');
                    return;
                  }
                  Navigator.pop(d);
                  await run(reason);
                  if (!mounted) return;
                  _refreshNow();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red.shade700,
                      content: Text(
                        '$room rejected (Reason: $reason)',
                        style: GoogleFonts.alice(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
              TextButton(
                child: Text(
                  'Cancel',
                  style: GoogleFonts.alice(color: Colors.grey.shade700),
                ),
                onPressed: () => Navigator.pop(d),
              ),
            ],
          );
        },
      ),
    );
  }
}
