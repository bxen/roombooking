import 'package:flutter/material.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';

class LecturerBookingHistoryListPage extends StatefulWidget {
  const LecturerBookingHistoryListPage({super.key});

  @override
  State<LecturerBookingHistoryListPage> createState() =>
      _LecturerBookingHistoryListPageState();
}

class _LecturerBookingHistoryListPageState
    extends State<LecturerBookingHistoryListPage> {
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<Map<String, String>> bookings = [
    {
      'room': 'Room C102',
      'date': '20 Oct 2025',
      'time': '10:00-12:00',
      'status': 'Approved',
      'borrower': 'Lionflower',
      'approvedBy': 'Mr.Krit',
      'objective': 'Presentation practice',
    },
    {
      'room': 'Room C101',
      'date': '22 Oct 2025',
      'time': '13:00-14:00',
      'status': 'Rejected',
      'borrower': 'Anna',
      'approvedBy': 'Mr.Krit',
      'objective': 'Project meeting',
      'reason': 'Room under maintenance',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = bookings.where((b) {
      final matchesFilter =
          selectedFilter == 'All' || b['status'] == selectedFilter;
      final matchesSearch =
          b['room']!.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();

    return Theme(
      data: LecturerTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking History'),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
              onPressed: () => showLecturerLogoutDialog(context),
            ),
          ],
        ),
        body: Column(
          children: [
            //-----------------search box------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search room...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
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
                      selected: selectedFilter == status,
                      onSelected: (_) => setState(() => selectedFilter = status),
                      selectedColor: const Color(0xFF8B0000),
                      labelStyle: TextStyle(
                        color: selectedFilter == status ? Colors.white : Colors.black,
                      ),
                    ),
                ],
              ),
            ),

            // ----------booking list----------------
            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                      child: Text(
                        'No booking history found.',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        final b = filtered[index];
                        return GestureDetector(
                          onTap: () => _showBookingPopup(context, b),
                          child: LecturerHistoryLine(
                            title: b['room']!,
                            date: b['date']!,
                            time: b['time']!,
                            status: b['status']!,
                            onTap: () => _showBookingPopup(context, b),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemCount: filtered.length,
                    ),
            ),
          ],
        ),
        bottomNavigationBar: lecturerBottomBar(context, 3),
      ),
    );
  }


    void _showBookingPopup(BuildContext context, Map<String, String> booking) {
    Color statusColor;
    switch (booking['status']) {
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              booking['room']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B0000),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: statusColor, width: 1),
              ),
              child: Text(
                booking['status']!,
                style: TextStyle(
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
              newLine('Approved by', booking['approvedBy']!),
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
            child: const Text('Close'),
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
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
}
