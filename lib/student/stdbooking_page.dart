import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:roombooking/student/student_home.dart';
import 'package:roombooking/student/widgets/student_navbar.dart';
import 'package:roombooking/services/api_client.dart';
import 'package:roombooking/services/session.dart';
class StdbookingPage extends StatefulWidget {
  final int roomId;
  final String roomName;
  final String roomStatus; // free|disabled
  final String? imagePath;
  final List<Map<String, dynamic>>
  timeSlots; // [{slot_id,start,end,status}, ...]
  final bool userAlreadyBookedToday;

  const StdbookingPage({
    super.key,
    required this.roomId,
    required this.roomName,
    required this.roomStatus,
    required this.imagePath,
    required this.timeSlots,
    required this.userAlreadyBookedToday,
  });

  @override
  State<StdbookingPage> createState() => _StdbookingPageState();
}

class _StdbookingPageState extends State<StdbookingPage> {
  String? selectedObjective;
  Map<String, dynamic>? selectedSlot;
  final String currentDate = DateFormat('d MMMM yyyy').format(DateTime.now());
  final List<String> objectives = [
    'Presentation practice',
    'Group Study',
    'Meeting',
    'Research/Assignment',
  ];

  String _todayYMD() {
    final now = DateTime.now();
    final mm = now.month.toString().padLeft(2, '0');
    final dd = now.day.toString().padLeft(2, '0');
    return '${now.year}-$mm-$dd';
  }

  bool get _canBook {
    if (widget.roomStatus != 'free') return false;
    if (widget.userAlreadyBookedToday) return false;
    if (selectedSlot == null) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final freeSlots = widget.timeSlots
        .where((s) => s['status'] == 'free')
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const StudentNavbar(showBack: true, showProfile: false),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F5F0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: widget.imagePath == null
                          ? const SizedBox.shrink()
                          : Image.asset(
                              widget.imagePath!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  widget.roomName,
                                  style: GoogleFonts.alice(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  'Status: ${widget.roomStatus}',
                                  style: GoogleFonts.alice(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: widget.roomStatus == 'free'
                                        ? Colors.green[800]
                                        : Colors.red[800],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Objective:',
                                style: GoogleFonts.alice(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                value: selectedObjective,
                                hint: const Text('Select objective'),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                ),
                                items: objectives
                                    .map(
                                      (obj) => DropdownMenuItem(
                                        value: obj,
                                        child: Text(obj),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) =>
                                    setState(() => selectedObjective = value),
                              ),
                              const SizedBox(height: 20),

                              Text(
                                'Time:',
                                style: GoogleFonts.alice(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              DropdownButtonFormField<Map<String, dynamic>>(
                                value: selectedSlot,
                                hint: const Text('Select time slot'),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  border: InputBorder.none,
                                ),
                                items: freeSlots.map((s) {
                                  final label =
                                      '${(s["start"] as String).substring(0, 5)}–${(s["end"] as String).substring(0, 5)}';
                                  return DropdownMenuItem(
                                    value: s,
                                    child: Text(label),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    setState(() => selectedSlot = value),
                              ),
                              const SizedBox(height: 30),

                              Center(
                                child: ElevatedButton(
                                  onPressed: !_canBook
                                      ? null
                                      : () {
                                          _confirmBooking(context);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: Text(
                                    'Confirm Booking',
                                    style: GoogleFonts.alice(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              if (widget.userAlreadyBookedToday)
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Center(
                                    child: Text(
                                      'You already booked a slot today.',
                                      style: GoogleFonts.alice(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmBooking(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        final start = (selectedSlot!['start'] as String).substring(0, 5);
        final end = (selectedSlot!['end'] as String).substring(0, 5);
        return AlertDialog(
          backgroundColor: const Color(0xFFF8F5F0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(
            child: Text(
              'Are you sure you want \nto book this room?',
              textAlign: TextAlign.center,
              style: GoogleFonts.alice(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.roomName,
                style: GoogleFonts.alice(color: Colors.red, fontSize: 18),
              ),
              Text(
                'Date: $currentDate',
                style: GoogleFonts.alice(color: Colors.red, fontSize: 18),
              ),
              Text(
                'Time: $start–$end',
                style: GoogleFonts.alice(color: Colors.red, fontSize: 18),
              ),
              Text(
                'Objective: $selectedObjective',
                style: GoogleFonts.alice(color: Colors.red, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Once confirmed, the request will be sent for approval.',
                style: GoogleFonts.alice(color: Colors.red, fontSize: 18),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(ctx);
                try {
                  await api.post(
                    '/api/bookings',
                    body: {
                      'user_id': Session.userId,
                      'room_id': widget.roomId,
                      'slot_id': (selectedSlot!['slot_id'] as num).toInt(),
                      'date': _todayYMD(),
                      'purpose': selectedObjective,
                    },
                  );
                  if (!mounted) return;
                  // กลับไปหน้า Status (แท็บ 2) เพื่อเห็นรายการ pending
                  final home = context
                      .findAncestorStateOfType<StudentHomeState>();
                  if (home != null) {
                    home.changeTab(2);
                    Navigator.pop(context);
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StudentHome(initialIndex: 2),
                      ),
                    );
                  }
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        'Booking failed: $e',
                        style: GoogleFonts.alice(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
              ),
              child: Text(
                'Confirm',
                style: GoogleFonts.alice(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
