import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/staff/staff_theme.dart';
import 'package:roombooking/screens/home_screen.dart';

class SthistoryPage extends StatefulWidget {
  const SthistoryPage({super.key});

  @override
  State<SthistoryPage> createState() => _SthistoryPageState();
}

class _SthistoryPageState extends State<SthistoryPage> {
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<Map<String, String>> bookings = const [
    {
      'room': 'Room A201',
      'date': '20 Oct 2025',
      'time': '10:00–12:00',
      'borrower': 'Lionflower',
      'approvedBy': 'Dr. Somchai', 
      'status': 'Approved', 
      'objective': 'Presentation practice',
    },
    {
      'room': 'Room C101',
      'date': '20 Oct 2025',
      'time': '08:00–10:00',
      'borrower': 'Lionflower',
      'approvedBy': 'Dr. Krit', 
      'status': 'Rejected',
      'objective': 'Meeting',
      'reason': 'Room under maintenance', 
    },
     { 
      'room': 'Room B102',
      'date': '21 Oct 2025',
      'time': '13:00–15:00',
      'borrower': 'Anna',
      'approvedBy': 'Dr. Somchai', 
      'status': 'Approved', 
      'objective': 'Group Project',
    },
  ];

  @override
  Widget build(BuildContext context) {
      final filtered = bookings.where((b) {
      final matchesFilter =
          selectedFilter == 'All' || b['status'] == selectedFilter;
      final matchesSearch = b['room']!.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
      return matchesFilter && matchesSearch;
    }).toList();

    return Theme(
      data: StaffTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, 
          title: Text(
            'Booking History',
            style: GoogleFonts.alice(),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 32,
              ),
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
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
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
                        color: selectedFilter == status
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                      selected: selectedFilter == status,
                      onSelected: (_) =>
                          setState(() => selectedFilter = status),
                      backgroundColor: const Color(0xFFFAF0F0),
                      selectedColor: const Color(0xFF8B0000),
                    ),
                ],
              ),
            ),

            // ----------booking list----------------
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        'No booking history found.',
                        style: GoogleFonts.alice(color: Colors.white70, fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        final b = filtered[index];
                        return StaffHistoryLine( 
                          title: b['room']!,
                          date: b['date']!,
                          time: b['time']!,
                          status: b['status']!,
                          onTap: () => _showBookingPopup(context, b),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemCount: filtered.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingPopup(BuildContext context, Map<String, String> booking) {
    Color statusColor;
    switch (booking['status']) {
      case 'Approved':
      case 'Completed': 
        statusColor = Colors.green.shade700;
        break;
      case 'Rejected':
      case 'Canceled':
        statusColor = Colors.red.shade700;
        break;
      default:
        statusColor = Colors.orange.shade700;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),

        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              booking['room']!,
              style: GoogleFonts.alice(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF8B0000),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20), 
                border: Border.all(color: statusColor.withOpacity(0.5)), 
              ),
              child: Text(
                booking['status']!,
                style: GoogleFonts.alice(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        content: Container(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              newLine('Date', booking['date']!),
              newLine('Time', booking['time']!),
              newLine('Borrower', booking['borrower']!),
              newLine('Approved by', booking['approvedBy'] ?? '-'), 
              newLine('Objective', booking['objective']!),
              if (booking['reason'] != null)
                newLine('Reason', booking['reason']!),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF8B0000),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Close', style: GoogleFonts.alice()),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget newLine(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                '$label:',
                style: GoogleFonts.alice(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.alice(fontSize: 16),
              ),
            ),
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
      case 'Completed':
        statusColor = Colors.green.shade800; 
        statusBgColor = Colors.green.shade100.withOpacity(0.6); 
        statusBorderColor = Colors.green.shade600; 
        break;
      case 'Rejected':
      case 'Canceled':
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.alice(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$date • $time", 
                  style: GoogleFonts.alice(
                    fontSize: 14,
                    color: Colors.black, 

                  ),
                ),
              ],
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: statusBgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: statusBorderColor,
                  width: 1.5,
                ),
              ),
              child: Text(
                status,
                style: GoogleFonts.alice(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// (ฟังก์ชัน showStaffLogoutDialog เหมือนเดิม)
void showStaffLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Are you sure you \nwant to logout?',
          textAlign: TextAlign.center,
          style: GoogleFonts.alice(
            fontSize: 20, 
            fontWeight: FontWeight.bold,
            color: Colors.black, 
          ),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const StadiumBorder(),
            ),
            child: Text(
              'Logout',
              style: GoogleFonts.alice(color: Colors.white, fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.alice(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      );
    },
  );
}
