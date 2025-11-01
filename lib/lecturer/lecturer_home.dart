import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'lecturer_theme.dart';
import 'lecturer_widgets.dart';
import 'lecturer_booking_requests_list_page.dart';

class LecturerHome extends StatelessWidget {
  const LecturerHome({super.key});

  static const _r = 20.0; // radius
  static const _g = 16.0; // gap

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: LecturerTheme.theme(),
      child: Scaffold(
        backgroundColor: const Color(0xFF8B0000), // Dark red background
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, c) {
              final h = c.maxHeight;
              final cardH = (h * 0.24).clamp(110.0, 180.0);

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Welcome !',
                                  style: GoogleFonts.alice(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    height: 1.1,
                                  ),
                                ),
                              ),
                              lecturerProfileButton(context),
                            ],
                          ),
                          const SizedBox(height: _g),

                          // Dashboard Section
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(_r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dashboard',
                                  style: GoogleFonts.alice(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 14),

                                // 2x2 Card Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: _dashCard(
                                        'Free',
                                        '10',
                                        Colors.green,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _dashCard(
                                        'Pending',
                                        '7',
                                        Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _dashCard(
                                        'Reserved',
                                        '3',
                                        Colors.redAccent,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _dashCard(
                                        'Disable',
                                        '5',
                                        Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: _g),

                          // Pending Requests Section
                          _buildPendingRequestsCard(context),

                          const SizedBox(height: _g), // Add bottom space
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: _g),
                  // Bottom bar
                  lecturerBottomBar(context, 0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Dashboard Card
  Widget _dashCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: GoogleFonts.alice(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.alice(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --- ADDED WIDGETS ---

  // Pending Requests Card
  Widget _buildPendingRequestsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5), // Same color as Dashboard
        borderRadius: BorderRadius.circular(_r), // Use same radius
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Title + View All button)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pending Requests',
                style: GoogleFonts.alice(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all requests page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LecturerBookingRequestsListPage(),
                    ),
                  );
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.alice(
                    color: Theme.of(context).primaryColor, // Use primary theme color
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),

          // --- MOCK DATA ---
          // In the future, this section will fetch real data
          _buildRequestItem(
            context,
            'Room A101',
            '1 Nov 2025 (10:00 - 12:00)',
          ),
          const Divider(height: 16, indent: 16, endIndent: 16),
          _buildRequestItem(
            context,
            'Room C201',
            '1 Nov 2025 (13:00 - 15:00)',
          ),
          const Divider(height: 16, indent: 16, endIndent: 16),
          _buildRequestItem(
            context,
            'Room B102',
            '2 Nov 2025 (09:00 - 11:00)',
          ),
          // --- END MOCK DATA ---
        ],
      ),
    );
  }

  // request item
  Widget _buildRequestItem(BuildContext context, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      leading: Icon(Icons.hourglass_top_rounded, color: Colors.orange.shade700),
      title: Text(
        title,
        style: GoogleFonts.alice(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.alice(
          color: Colors.black54,
          fontSize: 14,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LecturerBookingRequestsListPage()));
      },
    );
  }
}

// Quick Action Button (your original code)
Widget _quickAction({
  required IconData icon,
  required String label,
  required Color color,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.alice(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}