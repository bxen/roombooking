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
  // สีตามแบบ
  static const Color maroon = Color(0xFF6B0000);
  static const Color cardBg = Color(0xFFF7F4EF);

  // ข้อมูลตัวอย่าง
  final List<Map<String, String>> _bookings = const [
    {
      'room': 'A207',
      'date': '20 Oct 2025',
      'time': '10:00–12:00',
      'borrower': 'Lionflower',
      'approver': 'Dr. Somchai',
      'status': 'Completed',
      'objective': 'Presentation practice',
    },
    {
      'room': 'C101',
      'date': '20 Oct 2025',
      'time': '08:00–10:00',
      'borrower': 'Lionflower',
      'approver': 'Dr. Krit',
      'status': 'Canceled',
      'objective': 'Meeting',
    },
  ];

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
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            'Booking History',
            style: GoogleFonts.playfairDisplay(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        actions: [
          // profile -> dialog logout
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
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
                        color: Colors.black87,
                      ),
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      // Logout
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // ปิด dialog ก่อน
                          // ไปหน้า HomeScreen (ถ้าหมายถึงออกจากระบบจริงๆ แนะนำไปหน้า Login + clear stack)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HomeScreen(),
                            ),
                          );
                          // ถ้าต้องการเคลียร์ทุกหน้าก่อนออก:
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(builder: (_) => const LoginScreen()),
                          //   (route) => false,
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          'Logout',
                          style: GoogleFonts.alice(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      // Cancel
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 10,
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.alice(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 28),
          itemCount: _bookings.length,
          separatorBuilder: (_, __) => const SizedBox(height: 18),
          itemBuilder: (context, index) {
            final b = _bookings[index];
            return _BookingCard(
              room: b['room']!,
              date: b['date']!,
              time: b['time']!,
              borrower: b['borrower']!,
              approver: b['approver']!,
              status: b['status']!,
              objective: b['objective']!,
            );
          },
        ),
      ),
      // ⚠️ ไม่ใส่ bottomNavigationBar ที่หน้านี้ เพื่อไม่ให้ซ้อนกับของหน้าแม่
    );
  }
}

// การ์ดประวัติ
class _BookingCard extends StatelessWidget {
  const _BookingCard({
    required this.room,
    required this.date,
    required this.time,
    required this.borrower,
    required this.approver,
    required this.status,
    required this.objective,
  });

  final String room;
  final String date;
  final String time;
  final String borrower;
  final String approver;
  final String status;
  final String objective;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _SthistoryPageState.cardBg,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _kv('Room', room),
          _kv('Date', date),
          _kv('Time', time),
          _kv('Borrower', borrower, boldKey: true),
          _kv('Approver', approver, boldKey: true),
          _kv('Status', status, boldKey: true),
          _kv('Objective', objective, boldKey: true),
        ],
      ),
    );
  }

  Widget _kv(String k, String v, {bool boldKey = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            height: 1.35,
          ),
          children: [
            TextSpan(
              text: '$k : ',
              style: TextStyle(
                fontWeight: boldKey ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
            TextSpan(text: v),
          ],
        ),
      ),
    );
  }
}
