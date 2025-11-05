import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../services/api_client.dart';
import 'staff_theme.dart';
import '../screens/home_screen.dart';

class SthistoryPage extends StatefulWidget {
  const SthistoryPage({super.key});
  @override
  State<SthistoryPage> createState() => _SthistoryPageState();
}

class _SthistoryPageState extends State<SthistoryPage> {
  String selectedFilter = 'All'; // All | Approved | Rejected
  String searchQuery = '';
  late Future<List<Map<String, dynamic>>> _items;

  @override
  void initState() {
    super.initState();
    _items = _fetchHistory();
  }

  Future<List<Map<String, dynamic>>> _fetchHistory() async {
    // expected each row:
    // { booking_id, room_name, booking_date(YYYY-MM-DD), start_time, end_time, borrower, approved_by, status, purpose, reason? }
    final data = await api.get('/api/staff/history') as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: StaffTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Booking History', style: GoogleFonts.alice()),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
              onPressed: () => showStaffLogoutDialog(context),
            ),
          ],
        ),
        body: Column(
          children: [
            //-----------------search box------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: TextField(
                style: GoogleFonts.alice(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Search room...',
                  hintStyle: GoogleFonts.alice(color: Colors.black54),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color(0xFFFAF0F0),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                onChanged: (val) => setState(() => searchQuery = val),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Wrap(
                spacing: 8,
                children: [
                  for (var status in ['All', 'Approved', 'Rejected'])
                    ChoiceChip(
                      label: Text(status),
                      labelStyle: GoogleFonts.alice(
                          color: selectedFilter == status ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                      selected: selectedFilter == status,
                      onSelected: (_) => setState(() => selectedFilter = status),
                      backgroundColor: const Color(0xFFFAF0F0),
                      selectedColor: const Color(0xFF8B0000),
                    ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _items,
                builder: (_, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snap.hasError) {
                    return Center(child: Text('Error: ${snap.error}', style: GoogleFonts.alice(color: Colors.white)));
                  }
                  final rows = (snap.data ?? [])
                      .where((b) => selectedFilter == 'All' || _toDisplayStatus(b['status']) == selectedFilter)
                      .where((b) => (b['room_name'] as String).toLowerCase().contains(searchQuery.toLowerCase()))
                      .toList();

                  if (rows.isEmpty) {
                    return Center(
                        child: Text('No booking history found.',
                            style: GoogleFonts.alice(color: Colors.white70, fontSize: 16)));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemCount: rows.length,
                    itemBuilder: (_, i) {
                      final b = rows[i];
                      return StaffHistoryLine(
                        title: b['room_name'] as String,
                        date: _fmtDate(b['booking_date'] as String),
                        time:
                            '${(b['start_time'] as String).substring(0, 5)}–${(b['end_time'] as String).substring(0, 5)}',
                        status: _toDisplayStatus(b['status']),
                        onTap: () => _showBookingPopup(context, b),
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

  String _fmtDate(String ymd) {
    // 2025-10-26 -> 26 Oct 2025
    try {
      final d = DateTime.parse(ymd);
      return DateFormat('d MMM yyyy').format(d);
    } catch (_) {
      return ymd;
    }
  }

  String _toDisplayStatus(String? raw) {
    switch ((raw ?? '').toLowerCase()) {
      case 'approved':
      case 'reserved': // ถ้าฝั่ง server ใช้ reserved หลัง approve
        return 'Approved';
      case 'rejected':
      case 'cancelled':
        return 'Rejected';
      default:
        return 'Approved'; // บางกรณี history อาจมีแต่เคสจบแล้ว
    }
  }

  void _showBookingPopup(BuildContext context, Map<String, dynamic> booking) {
    final dispStatus = _toDisplayStatus(booking['status'] as String?);
    Color statusColor;
    switch (dispStatus) {
      case 'Approved':
        statusColor = Colors.green.shade700;
        break;
      case 'Rejected':
        statusColor = Colors.red.shade700;
        break;
      default:
        statusColor = Colors.orange.shade700;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(booking['room_name'] as String,
              style: GoogleFonts.alice(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF8B0000),
                fontSize: 20,
              )),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: statusColor.withOpacity(0.5)),
            ),
            child: Text(dispStatus,
                style: GoogleFonts.alice(color: statusColor, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ]),
        content: Container(
          padding: const EdgeInsets.all(4),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            _line('Date', _fmtDate(booking['booking_date'] as String)),
            _line(
                'Time',
                '${(booking['start_time'] as String).substring(0, 5)}–'
                '${(booking['end_time'] as String).substring(0, 5)}'),
            _line('Borrower', (booking['borrower'] ?? '-') as String),
            _line('Approved by', (booking['approved_by'] ?? '-') as String),
            _line('Objective', (booking['purpose'] ?? '-') as String),
            if (booking['reason'] != null && (booking['reason'] as String).isNotEmpty)
              _line('Reason', booking['reason'] as String),
          ]),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF8B0000),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Close', style: GoogleFonts.alice()),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _line(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              child: Text('$label:',
                  style: GoogleFonts.alice(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            Expanded(child: Text(value, style: GoogleFonts.alice(fontSize: 16))),
          ],
        ),
      );
}

class StaffHistoryLine extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String status;
  final VoidCallback onTap;

  const StaffHistoryLine({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext c) {
    Color statusColor;
    Color statusBgColor;
    Color statusBorderColor;
    switch (status) {
      case 'Approved':
        statusColor = Colors.green.shade800;
        statusBgColor = Colors.green.shade100.withOpacity(0.6);
        statusBorderColor = Colors.green.shade600;
        break;
      case 'Rejected':
        statusColor = Colors.red.shade800;
        statusBgColor = Colors.red.shade100.withOpacity(0.6);
        statusBorderColor = Colors.red.shade600;
        break;
      default:
        statusColor = Colors.orange.shade800;
        statusBgColor = Colors.orange.shade100.withOpacity(0.6);
        statusBorderColor = Colors.orange.shade600;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF0F0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: GoogleFonts.alice(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 4),
            Text("$date • $time",
                style: GoogleFonts.alice(fontSize: 14, color: Colors.black)),
          ]),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: statusBorderColor, width: 1.5),
            ),
            child: Text(status,
                style: GoogleFonts.alice(
                    color: statusColor, fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ]),
      ),
    );
  }
}

void showStaffLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'Are you sure you \nwant to logout?',
        textAlign: TextAlign.center,
        style: GoogleFonts.alice(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: const StadiumBorder()),
          child:
              Text('Logout', style: GoogleFonts.alice(color: Colors.white, fontSize: 15)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: GoogleFonts.alice(color: Colors.black, fontSize: 15)),
        ),
      ],
    ),
  );
}
