import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/student/stdroomlist.dart';

class StdstatusPage extends StatelessWidget {
  const StdstatusPage({super.key});

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
                  Text(
                    'Booking Status',
                    style: GoogleFonts.alice(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
            ),

            // ---------- BODY ----------
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildBookingCard(
                    context,
                    room: 'A207',
                    date: '20 Oct 2025',
                    time: '10:00 - 12:00',
                    approver: 'Dr. Somchai',
                    status: 'Pending',
                    objective: 'Presentation practice',
                    note: 'Waiting for approval',
                    buttonText: 'Cancel Booking',
                    buttonColor: const Color(0xFFFF4D4D), // สีแดงแบบในรูป
                    showDialogOnPress: true,
                  ),
                  const SizedBox(height: 16),
                  _buildBookingCard(
                    context,
                    room: 'C101',
                    date: '20 Oct 2025',
                    time: '08:00 - 10:00',
                    approver: 'Dr. Krit',
                    status: 'Rejected',
                    objective: 'Meeting',
                    note: 'Room unavailable at that time',
                    buttonText: 'Book Again',
                    buttonColor: const Color(0xFF2EBF4F), // สีเขียวแบบในรูป
                    showDialogOnPress: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Booking Card ----------
  static Widget _buildBookingCard(
    BuildContext context, {
    required String room,
    required String date,
    required String time,
    required String approver,
    required String status,
    required String objective,
    required String note,
    required String buttonText,
    required Color buttonColor,
    required bool showDialogOnPress,
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
            _buildInfo('Approver', approver),
            _buildInfo('Status', status),
            _buildInfo('Objective', objective),
            _buildInfo('Note', note, color: Colors.red[700]),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  minimumSize: const Size(double.infinity, 42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: showDialogOnPress
                    ? () => _showConfirmDialog(context)
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Stdroomlist(),
                          ),
                        );
                        ;
                      },
                child: Text(
                  buttonText,
                  style: GoogleFonts.alice(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
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

  static void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Are you sure you want to cancel this booking?',
          textAlign: TextAlign.center,
          style: GoogleFonts.alice(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: const Text(
          'This action cannot be undone.',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(ctx),
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
