
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';


class LecturerRequestDetailMainPage extends StatelessWidget {
  const LecturerRequestDetailMainPage({super.key});

  @override
  Widget build(BuildContext context) {

    const String roomName = 'Room A102'; 

    return Theme(
      data: LecturerTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Booking Requests',
            style: GoogleFonts.alice(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
              onPressed: () => showLecturerLogoutDialog(context),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const LecturerRequestCard(
              room: roomName, 
              date: '20 Oct 2025',
              time: '11:00-13:00',
              borrower: 'Lionflower',
              objective: 'Midterm practice',
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showApproveDialog(context, roomName);
                    },
                    child: Text(
                      'Approve',
                      style: GoogleFonts.alice(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      _showRejectDialog(context, roomName);
                    },
                    child: Text(
                      'Reject',
                      style: GoogleFonts.alice(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: lecturerBottomBar(context, 2),
      ),
    );
  }


  // Approve Popup
  void _showApproveDialog(BuildContext context, String roomName) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
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
            'Do you want to approve the booking request for $roomName?',
            style: GoogleFonts.alice(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: GoogleFonts.alice(color: Colors.grey.shade700),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); 
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
              ),
              child: Text(
                'Approve',
                style: GoogleFonts.alice(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); 
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green.shade700,
                    content: Text(
                      '$roomName has been approved!',
                      style: GoogleFonts.alice(color: Colors.white), 
                    ),
                  ),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Reject Popup (with Reason)
  void _showRejectDialog(BuildContext context, String roomName) {
    final TextEditingController reasonController = TextEditingController();
    String? errorText; 

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
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
                    'Do you want to reject the booking request for $roomName?',
                    style: GoogleFonts.alice(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: reasonController,
                    autofocus: true, 
                    style: GoogleFonts.alice(color: Colors.black), 
                    decoration: InputDecoration(
                      labelText: 'Reason',
                      labelStyle: GoogleFonts.alice(color: Colors.black), 
                      hintText: 'e.g., Room unavailable, Maintenance',
                      hintStyle: GoogleFonts.alice(color: Colors.black), 
                      errorText: errorText, 
                      errorStyle: GoogleFonts.alice(color: Colors.black), 
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.alice(color: Colors.grey.shade700),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); 
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                  ),
                  child: Text(
                    'Reject',
                    style: GoogleFonts.alice(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onPressed: () {
                    final String reason = reasonController.text;
                    if (reason.trim().isEmpty) {
                      setState(() {
                        errorText = 'Please provide a reason';
                      });
                    } else {
                      Navigator.of(dialogContext).pop(); 
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red.shade700,
                          content: Text(
                            '$roomName rejected (Reason: $reason)',
                            style: GoogleFonts.alice(color: Colors.white), 
                          ),
                        ),
                      );
                      Navigator.of(context).pop(); 
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}