import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';
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
                              IconButton(
                                icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
                                onPressed: () => _showLogoutDialog(context),
                              ),
                            ],
                          ),
                          const SizedBox(height: _g),

                          // Dashboard
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF161616),
                              borderRadius: BorderRadius.circular(_r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Dashboard',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 12),
                                _dashRow(
                                  left: const _DashItem('Free', '10'),
                                  right: const _DashItem('Pending', '7'),
                                ),
                                const SizedBox(height: 10),
                                _dashRow(
                                  left: const _DashItem('Disable', '5'),
                                  right: const _DashItem('Reserved', '3'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: _g),

                          // รูปห้อง 2 รูป (แทนการ์ดเทา)
                          Row(
                            children: [
                              Expanded(
                                child: _imageCard('images/roomA101.jpg', cardH),
                              ),
                              const SizedBox(width: _g),
                              Expanded(
                                child: _imageCard('images/roomC103.jpg', cardH),
                              ),
                            ],
                          ),

                          const SizedBox(height: _g - 4),

                          // CTA
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  'View All\nBooking Requests',
                                  style: GoogleFonts.alice(color: Colors.white, height: 1.2),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => const LecturerBookingRequestsListPage()),
                                ),
                                borderRadius: BorderRadius.circular(22),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: const Icon(Icons.play_arrow, size: 18, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  lecturerBottomBar(context, 0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ---- การ์ดรูปห้อง ----
  Widget _imageCard(String path, double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // ---- Beautiful Logout Dialog ----
  void _showLogoutDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: 'logout',
      barrierDismissible: true,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 320,
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F1ED),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.logout, color: Colors.red, size: 28),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Are you sure you\nwant to logout?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alice(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: const StadiumBorder(),
                          ),
                          child: Text('Cancel',
                              style: GoogleFonts.alice(fontSize: 15, color: Colors.black)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const HomeScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: const StadiumBorder(),
                          ),
                          child: Text('Logout',
                              style: GoogleFonts.alice(fontSize: 15, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return Transform.scale(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(anim).value,
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    );
  }

  Widget _dashRow({required _DashItem left, required _DashItem right}) {
    const label = TextStyle(color: Colors.white, fontSize: 14);
    const value = TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15);

    Widget cell(_DashItem it) => Row(
          children: [
            const Icon(Icons.receipt_long, size: 16, color: Colors.white),
            const SizedBox(width: 6),
            Text(it.label, style: label),
            const Spacer(),
            Text(it.value, style: value),
          ],
        );

    return Row(
      children: [
        Expanded(child: cell(left)),
        const SizedBox(width: 14),
        Expanded(child: cell(right)),
      ],
    );
  }
}

class _DashItem {
  final String label;
  final String value;
  const _DashItem(this.label, this.value);
}
