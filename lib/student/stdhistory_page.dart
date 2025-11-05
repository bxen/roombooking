import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/student/widgets/student_navbar.dart';
import 'package:roombooking/services/api_client.dart';
import 'package:roombooking/services/session.dart';
import 'package:intl/intl.dart';


class StdhistoryPage extends StatefulWidget {
  const StdhistoryPage({super.key});

  @override
  State<StdhistoryPage> createState() => _StdhistoryPageState();
}

class _StdhistoryPageState extends State<StdhistoryPage> {
  late Future<List<Map<String, dynamic>>> _history;

  String _fmtDate(String ymd) {
  try {
    final d = DateTime.parse(ymd);
    return DateFormat('d MMM yyyy').format(d);
  } catch (_) {
    return ymd;
  }
}



  @override
  void initState() {
    super.initState();
    _history = _fetchHistory();
  }

  Future<List<Map<String, dynamic>>> _fetchHistory() async {
    final res =
        await api.get(
              '/api/student/bookings',
              query: {
                'scope': 'history',
                'user_id': Session.userId, // << ส่ง user_id
              },
            )
            as List<dynamic>;
    return res.cast<Map<String, dynamic>>();
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
                title: 'Booking History',
                profileIconSize: 28,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _history,
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
                      child: Text(
                        'No booking history.',
                        style: GoogleFonts.alice(color: Colors.white),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: list.length,
                    itemBuilder: (_, i) {
                      final b = list[i];
                      final status = (b['status'] as String)
                          .toLowerCase(); // approved|rejected|reserved|cancelled|completed
                      final room = b['room_name'] as String;
                      final date = _fmtDate(b['booking_date'] as String);
                      final start = (b['start_time'] as String).substring(0, 5);
                      final end = (b['end_time'] as String).substring(0, 5);
                      final borrower = b['borrower'] as String? ?? '-';
                      final approver = b['approver'] as String? ?? '-';
                      final objective = b['purpose'] as String? ?? '-';
                      final reason = b['rejection_reason'] as String?;

                      Color statusColor;
                      IconData statusIcon;
                      switch (status) {
                        case 'completed':
                        case 'approved':
                          statusColor = Colors.green;
                          statusIcon = Icons.check_circle;
                          break;
                        case 'rejected':
                        case 'cancelled':
                          statusColor = Colors.red;
                          statusIcon = Icons.cancel;
                          break;
                        default:
                          statusColor = Colors.orange;
                          statusIcon = Icons.hourglass_bottom;
                      }

                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDFCFB),
                          borderRadius: BorderRadius.circular(16),
                          border: Border(
                            left: BorderSide(color: statusColor, width: 6),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(statusIcon, color: statusColor, size: 22),
                                const SizedBox(width: 8),
                                Text(
                                  'Room : $room',
                                  style: GoogleFonts.alice(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF161616),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            _info('Date', date),
                            _info('Time', '$start - $end'),
                            _info('Borrower', borrower),
                            _info('Approver', approver),
                            _info('Objective', objective),
                            if (reason != null && reason.isNotEmpty)
                              _info('Reason', reason, color: Colors.red),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Status: ${status[0].toUpperCase()}${status.substring(1)}',
                                style: GoogleFonts.alice(
                                  color: statusColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
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
    );
  }

  Widget _info(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        '$label : $value',
        style: GoogleFonts.alice(
          color: color ?? const Color(0xFF161616),
          fontSize: 16,
          height: 1.3,
        ),
      ),
    );
  }
}
