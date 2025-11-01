import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';
import 'package:roombooking/staff/staff_home.dart';

class SthistoryPage extends StatefulWidget {
  const SthistoryPage({super.key});

  @override
  State<SthistoryPage> createState() => _SthistoryPageState();
}

class _SthistoryPageState extends State<SthistoryPage> {
  // สีตามแบบในรูป
  static const Color maroon = Color(0xFF630000); // พื้นหลัง
  static const Color chipSelected = Color(0xFF8B0000); // ปุ่ม All ตอนเลือก
  static const Color cardBg = Color(0xFFF7F4EF); // พื้นการ์ด
  static const Color greyText = Color(0xFF6B6B6B); // สีตัวหนังสือวันที่เวลา

  String selectedFilter = 'All';
  String searchQuery = '';

  // ข้อมูลตัวอย่างให้ตรงกับรูป
  final List<Map<String, String>> _bookings = const [
    {
      'room': 'Room C102',
      'date': '20 Oct 2025',
      'time': '10:00-12:00',
      'status': 'Approved',
    },
    {
      'room': 'Room C101',
      'date': '22 Oct 2025',
      'time': '13:00-14:00',
      'status': 'Rejected',
    },
  ];

  List<Map<String, String>> get _filtered {
    return _bookings.where((b) {
      final passFilter = selectedFilter == 'All'
          ? true
          : b['status'] == selectedFilter;
      final passSearch = b['room']!.toLowerCase().contains(
        searchQuery.trim().toLowerCase(),
      );
      return passFilter && passSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maroon,
      appBar: AppBar(
        backgroundColor: maroon,
        elevation: 0,
        toolbarHeight: 72,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Booking History',
            style: GoogleFonts.alice(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 14),
            child: Icon(Icons.account_circle, color: Colors.white, size: 32),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            // กล่องค้นหา
            _SearchBox(
              hint: 'Search room...',
              onChanged: (v) => setState(() => searchQuery = v),
            ),
            const SizedBox(height: 12),

            // ชิปตัวกรอง
            Row(
              children: [
                _FilterChip(
                  label: 'All',
                  selected: selectedFilter == 'All',
                  onTap: () => setState(() => selectedFilter = 'All'),
                ),
                const SizedBox(width: 12),
                _OutlineFilterChip(
                  label: 'Approved',
                  selected: selectedFilter == 'Approved',
                  onTap: () => setState(() => selectedFilter = 'Approved'),
                ),
                const SizedBox(width: 12),
                _OutlineFilterChip(
                  label: 'Rejected',
                  selected: selectedFilter == 'Rejected',
                  onTap: () => setState(() => selectedFilter = 'Rejected'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // การ์ดรายการ
            ..._filtered.map(
              (b) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _HistoryCard(
                  room: b['room']!,
                  date: b['date']!,
                  time: b['time']!,
                  status: b['status']!,
                ),
              ),
            ),
            if (_filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Center(
                  child: Text(
                    'No history',
                    style: GoogleFonts.alice(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      // หมายเหตุ: ถ้ามี bottomNavigationBar จากหน้าแม่อยู่แล้ว อย่าใส่ที่หน้านี้ซ้ำ
    );
  }
}

/// ---------------- Widgets ----------------

class _SearchBox extends StatelessWidget {
  const _SearchBox({required this.hint, required this.onChanged});
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.black45),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: GoogleFonts.alice(fontSize: 16),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: GoogleFonts.alice(
                  color: Colors.black38,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ปุ่ม All แบบทึบ (selected)
class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? _SthistoryPageState.chipSelected : Colors.white24;
    final fg = Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            if (selected) ...[
              const Icon(Icons.check, size: 18, color: Colors.white),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: GoogleFonts.alice(
                color: fg,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ปุ่ม Approved/Rejected แบบขอบ (outline)
class _OutlineFilterChip extends StatelessWidget {
  const _OutlineFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final border = Border.all(color: Colors.white70, width: 1.6);
    final bg = selected ? Colors.white10 : Colors.white10;
    final fg = Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: border,
        ),
        child: Text(
          label,
          style: GoogleFonts.alice(
            color: fg,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// การ์ดรายการประวัติ
class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.room,
    required this.date,
    required this.time,
    required this.status,
  });

  final String room;
  final String date;
  final String time;
  final String status;

  @override
  Widget build(BuildContext context) {
    final isApproved = status == 'Approved';
    final badgeBorder = Border.all(
      color: isApproved ? const Color(0xFF83C28B) : const Color(0xFFE58C8C),
      width: 2,
    );
    final badgeBg = isApproved
        ? const Color(0xFFEFF8F0)
        : const Color(0xFFFFEFEF);
    final badgeText = isApproved
        ? const Color(0xFF2E7D32)
        : const Color(0xFFD32F2F);

    return Container(
      decoration: BoxDecoration(
        color: _SthistoryPageState.cardBg,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ซ้าย: ชื่อห้อง + วันที่/เวลา
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room,
                  style: GoogleFonts.alice(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      date,
                      style: GoogleFonts.alice(
                        color: _SthistoryPageState.greyText,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text('•'),
                    const SizedBox(width: 12),
                    Text(
                      time,
                      style: GoogleFonts.alice(
                        color: _SthistoryPageState.greyText,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ขวา: สถานะวงรี
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: badgeBg,
              border: badgeBorder,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              status,
              style: GoogleFonts.alice(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: badgeText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
