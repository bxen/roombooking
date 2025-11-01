// import 'package:flutter/material.dart';
// // import 'lecturer_theme.dart';
// // import 'lecturer_widgets.dart';
// // import 'lecturer_request_detail_main_page.dart';
// // import 'lecturer_request_detail_approve_page.dart';
// // import 'lecturer_request_detail_reject_page.dart';

// // class LecturerBookingRequestsListPage extends StatelessWidget {
// //   const LecturerBookingRequestsListPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Theme(
// //       data: LecturerTheme.theme(),
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Booking Requests'),
// //           actions: [
// //             IconButton(
// //               icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
// //               onPressed: () => showLecturerLogoutDialog(context),
// //             ),
// //           ],
// //         ),
// //         body: ListView(
// //           padding: const EdgeInsets.all(16),
// //           children: [
// //             LecturerRequestCard(
// //               room: 'Room A307',
// //               date: '20 Oct 2025',
// //               time: '11:00-13:00',
// //               borrower: 'ID: 65070001',
// //               objective: 'Midterm practice',
// //               onTap: () => Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const LecturerRequestDetailMainPage()),
// //               ),
// //               actions: [
// //                 Expanded(
// //                   child: ElevatedButton(
// //                     onPressed: () => Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (_) => const LecturerRequestDetailApprovePage()),
// //                     ),
// //                     child: const Text('Approve'),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 Expanded(
// //                   child: ElevatedButton(
// //                     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
// //                     onPressed: () => Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (_) => const LecturerRequestDetailRejectPage()),
// //                     ),
// //                     child: const Text('Reject'),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 12),
// //             LecturerRequestCard(
// //               room: 'Room C101',
// //               date: '21 Oct 2025',
// //               time: '09:00-10:00',
// //               borrower: 'ID: 65070099',
// //               objective: 'Lab review',
// //               onTap: () => Navigator.push(
// //                 context,
// //                 MaterialPageRoute(builder: (_) => const LecturerRequestDetailMainPage()),
// //               ),
// //               actions: [
// //                 Expanded(
// //                   child: ElevatedButton(
// //                     onPressed: () => Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (_) => const LecturerRequestDetailApprovePage()),
// //                     ),
// //                     child: const Text('Approve'),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 8),
// //                 Expanded(
// //                   child: ElevatedButton(
// //                     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
// //                     onPressed: () => Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (_) => const LecturerRequestDetailRejectPage()),
// //                     ),
// //                     child: const Text('Reject'),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //         bottomNavigationBar: lecturerBottomBar(context, 2),
// //       ),
// //     );
// //   }
// // }


// import 'lecturer_theme.dart';
// import 'lecturer_widgets.dart';
// import 'lecturer_request_detail_main_page.dart';
// import 'lecturer_request_detail_approve_page.dart';
// import 'lecturer_request_detail_reject_page.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LecturerBookingRequestsListPage extends StatelessWidget {
//   const LecturerBookingRequestsListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: LecturerTheme.theme(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Booking Requests'),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
//               onPressed: () => showLecturerLogoutDialog(context),
//             ),
//           ],
//           // --- ไม่ต้องมี TabBar ที่นี่ ---
//         ),
//         // --- ใช้ ListView เดียวเหมือนเดิม ---
//         body: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             // --- 1. หัวข้อ Pending ---
//             _buildSectionHeader(
//               'Pending',
//               Icons.hourglass_top_rounded,
//               Colors.orange.shade700,
//             ),
//             const SizedBox(height: 8),

//             // การ์ด Pending (มีปุ่ม)
//             LecturerRequestCard(
//               room: 'Room A307',
//               date: '20 Oct 2025',
//               time: '11:00-13:00',
//               borrower: 'ID: 65070001',
//               objective: 'Midterm practice',
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const LecturerRequestDetailMainPage()),
//               ),
//               actions: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const LecturerRequestDetailApprovePage()),
//                     ),
//                     child: const Text('Approve'),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                     onPressed: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const LecturerRequestDetailRejectPage()),
//                     ),
//                     child: const Text('Reject'),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             LecturerRequestCard(
//               room: 'Room C101',
//               date: '21 Oct 2025',
//               time: '09:00-10:00',
//               borrower: 'ID: 65070099',
//               objective: 'Lab review',
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const LecturerRequestDetailMainPage()),
//               ),
//               actions: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const LecturerRequestDetailApprovePage()),
//                     ),
//                     child: const Text('Approve'),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                     onPressed: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => const LecturerRequestDetailRejectPage()),
//                     ),
//                     child: const Text('Reject'),
//                   ),
//                 ),
//               ],
//             ),

//             // --- เส้นคั่น ---
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.0),
//               child: Divider(),
//             ),

//             // --- 2. หัวข้อ Approved ---
//             _buildSectionHeader(
//               'Approved',
//               Icons.check_circle_rounded,
//               Colors.green.shade700,
//             ),
//             const SizedBox(height: 8),

//             // การ์ด Approved (ไม่มีปุ่ม)
//             LecturerRequestCard(
//               room: 'Room B102',
//               date: '18 Oct 2025',
//               time: '14:00-16:00',
//               borrower: 'ID: 65070011',
//               objective: 'Group Project Meeting',
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const LecturerRequestDetailMainPage()),
//               ),
//               // ไม่มี actions
//             ),

//             // --- เส้นคั่น ---
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.0),
//               child: Divider(),
//             ),

//             // --- 3. หัวข้อ Rejected ---
//             _buildSectionHeader(
//               'Rejected',
//               Icons.cancel_rounded,
//               Colors.red.shade700,
//             ),
//             const SizedBox(height: 8),

//             // การ์ด Rejected (ไม่มีปุ่ม)
//             LecturerRequestCard(
//               room: 'Room A307',
//               date: '19 Oct 2025',
//               time: '09:00-12:00',
//               borrower: 'ID: 65070022',
//               objective: 'Special Lecture Prep',
//               onTap: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const LecturerRequestDetailMainPage()),
//               ),
//               // ไม่มี actions
//             ),
//           ],
//         ),
//         bottomNavigationBar: lecturerBottomBar(context, 2),
//       ),
//     );
//   }

//   // --- Widget สำหรับสร้างหัวข้อ ---
//   // (วางอันนี้ไว้ด้านล่าง `build` method)
//   Widget _buildSectionHeader(String title, IconData icon, Color color) {
//     return Row(
//       children: [
//         Icon(icon, color: color, size: 22),
//         const SizedBox(width: 8),
//         Text(
//           title,
//           style: GoogleFonts.alice(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';
import 'lecturer_request_detail_main_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LecturerBookingRequestsListPage extends StatelessWidget {
  const LecturerBookingRequestsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: LecturerTheme.theme(),
      child: Scaffold(
        appBar: AppBar(
          // --- 1. AppBar Title ---
          title: Text(
            'Booking Requests',
            style: GoogleFonts.alice(), // Applied font
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
            // --Header ---
            _buildSectionHeader(
              'Pending',
              Icons.hourglass_top_rounded,
              Colors.orange.shade700,
            ),
            const SizedBox(height: 8),

            // Pending Card (with buttons)
            LecturerRequestCard(
              room: 'Room A307',
              date: '20 Oct 2025',
              time: '11:00-13:00',
              borrower: 'ID: 65070001',
              objective: 'Midterm practice',
              actions: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showApproveDialog(context, 'Room A307');
                    },
                    // --- 2. Button Text ---
                    child: Text(
                      'Approve',
                      style: GoogleFonts.alice(fontWeight: FontWeight.bold), // Applied font
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      _showRejectDialog(context, 'Room A307');
                    },
                    // --- 3. Button Text (Red) ---
                    child: Text(
                      'Reject',
                      style: GoogleFonts.alice(fontWeight: FontWeight.bold, color: Colors.white), // Applied font
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LecturerRequestCard(
              room: 'Room C101',
              date: '21 Oct 2025',
              time: '09:00-10:00',
              borrower: 'ID: 65070099',
              objective: 'Lab review',
              actions: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                       _showApproveDialog(context, 'Room C101');
                    },
                    // --- 4. Button Text ---
                    child: Text(
                      'Approve',
                      style: GoogleFonts.alice(fontWeight: FontWeight.bold), // Applied font
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                     onPressed: () {
                      _showRejectDialog(context, 'Room C101');
                    },
                    // --- 5. Button Text (Red) ---
                    child: Text(
                      'Reject',
                      style: GoogleFonts.alice(fontWeight: FontWeight.bold, color: Colors.white), // Applied font
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

  // Widget for creating section headers (Already uses Alice)
  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.alice(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  // Approve Popup (Already uses Alice for most text)
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
                    // --- 6. SnackBar Text ---
                    content: Text(
                      '$roomName has been approved!',
                      style: GoogleFonts.alice(color: Colors.white), // Applied font
                    ),
                  ),
                );
                // TODO: Add actual approval logic
              },
            ),
          ],
        );
      },
    );
  }

  // ----------REJECT POPUP (All text updated)--------------
  void _showRejectDialog(BuildContext context, String roomName) {
    final TextEditingController reasonController = TextEditingController();
    String? errorText; 

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
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
                  // --- 7. TextField Styles ---
                  TextField(
                    controller: reasonController,
                    autofocus: true, 
                    style: GoogleFonts.alice(), // Style for text being typed
                    decoration: InputDecoration(
                      labelText: 'Reason',
                      labelStyle: GoogleFonts.alice(), // Applied font
                      hintText: 'e.g., Room unavailable, Maintenance',
                      hintStyle: GoogleFonts.alice(), // Applied font
                      errorText: errorText, 
                      errorStyle: GoogleFonts.alice(), // Applied font
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
                      
                      // --- 8. SnackBar Text ---
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red.shade700,
                          content: Text(
                            '$roomName rejected (Reason: $reason)',
                            style: GoogleFonts.alice(color: Colors.white), // Applied font
                          ),
                        ),
                      );
                      // TODO: Add actual rejection logic
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