import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';

class StdhistoryPage extends StatelessWidget {
  const StdhistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF6F0000),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- APP BAR ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  Text(
                    'Booking History',
                    style: GoogleFonts.alice(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 28,
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
                              ),
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const HomeScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: const StadiumBorder(),
                                ),
                                child: Text(
                                  'Logout',
                                  style: GoogleFonts.alice(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
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
                ],
              ),
            ),

            // ---------- BODY ----------
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildHistoryCard(
                    room: 'A207',
                    date: '20 Oct 2025',
                    time: '10:00 - 12:00',
                    borrower: 'Lionflower',
                    approver: 'Dr. Somchai',
                    status: 'Completed',
                    objective: 'Presentation practice',
                    note: 'Room used successfully',
                  ),
                  const SizedBox(height: 16),
                  _buildHistoryCard(
                    room: 'C101',
                    date: '20 Oct 2025',
                    time: '08:00 - 10:00',
                    borrower: 'Lionflower',
                    approver: 'Dr. Krit',
                    status: 'Canceled',
                    objective: 'Meeting',
                    note: 'Room unavailable',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- History Card ----------
  static Widget _buildHistoryCard({
    required String room,
    required String date,
    required String time,
    required String borrower,
    required String approver,
    required String status,
    required String objective,
    required String note,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFFF2F1ED),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfo('Room', room),
            _buildInfo('Date', date),
            _buildInfo('Time', time),
            _buildInfo('Borrower', borrower),
            _buildInfo('Approver', approver),
            _buildInfo('Status', status),
            _buildInfo('Objective', objective),
            _buildInfo('Note', note, color: Colors.black87),
          ],
        ),
      ),
    );
  }

  static Widget _buildInfo(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        '$label : $value',
        style: GoogleFonts.alice(
          color: color ?? const Color(0xFF161616),
          fontSize: 15,
          height: 1.3,
        ),
      ),
    );
  }
}
