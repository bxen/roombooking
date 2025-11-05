import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/staff/staff_addroom.dart';
import 'package:roombooking/staff/staff_assetlist.dart';
import 'package:roombooking/staff/sthistory_page.dart';
import '../services/api_client.dart';
import 'package:roombooking/screens/home_screen.dart';


class StaffHome extends StatefulWidget {
  const StaffHome({super.key});
  @override
  State<StaffHome> createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    StaffHomePage(),
    StaffAssetList(), // browse room list page
    StaffAddroom(),
    SthistoryPage(),
  ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF600000),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label: 'Rooms'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: 'History'),
        ],
      ),
    );
  }
}

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({super.key});
  @override
  State<StaffHomePage> createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  late Future<_Summary> _summary;

  static const _r = 20.0; // radius
  static const _g = 16.0; // gap

  @override
  void initState() {
    super.initState();
    _summary = _fetchSummary();
  }

  Future<_Summary> _fetchSummary() async {
    // expected: { available, pending, booked, disabled }
    final m = await api.get('/api/staff/summary') as Map<String, dynamic>;
    return _Summary(
      available: (m['available'] as num?)?.toInt() ?? 0,
      pending: (m['pending'] as num?)?.toInt() ?? 0,
      booked: (m['booked'] as num?)?.toInt() ?? 0,
      disabled: (m['disabled'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header ---
            const _StaffNavbar(leadingText: 'Welcome !'),
            const SizedBox(height: _g),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(_r),
              ),
              child: FutureBuilder<_Summary>(
                future: _summary,
                builder: (_, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final s = snap.data ?? const _Summary();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dashboard',
                          style: GoogleFonts.alice(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          )),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(child: _dashCard('Available', '${s.available}', Colors.green)),
                          const SizedBox(width: 12),
                          Expanded(child: _dashCard('Pending', '${s.pending}', Colors.orange)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(child: _dashCard('Booked', '${s.booked}', Colors.redAccent)),
                          const SizedBox(width: 12),
                          Expanded(child: _dashCard('Disable', '${s.disabled}', Colors.grey)),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: _g),
            Text('Quick Actions',
                style: GoogleFonts.alice(
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                )),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _quickAction(
                    icon: Icons.add_home_work_rounded,
                    label: 'Add Room',
                    color: Colors.white,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StaffAddroom()));
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _quickAction(
                    icon: Icons.edit_location_alt_rounded,
                    label: 'Manage Rooms',
                    color: Colors.white,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StaffAssetList()));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: _g),
          ],
        ),
      ),
    );
  }

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
          Text(label,
              style: GoogleFonts.alice(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 6),
          Text(value,
              style: GoogleFonts.alice(
                color: color,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

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
            Text(label,
                textAlign: TextAlign.center,
                style: GoogleFonts.alice(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _Summary {
  final int available, pending, booked, disabled;
  const _Summary({this.available = 0, this.pending = 0, this.booked = 0, this.disabled = 0});
}

class _StaffNavbar extends StatelessWidget {
  final String leadingText;
  const _StaffNavbar({required this.leadingText});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(leadingText,
            style: GoogleFonts.alice(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.white, size: 32),
          onPressed: () => _showLogoutDialog(context),
        ),
      ],
    );
  }
}

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Are you sure you \nwant to logout?', textAlign: TextAlign.center, style: GoogleFonts.alice(fontSize: 20, fontWeight: FontWeight.bold)),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, shape: const StadiumBorder()),
            child: Text('Logout', style: GoogleFonts.alice(color: Colors.white, fontSize: 15)),
          ),
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.alice(color: Colors.black, fontSize: 15))),
        ],
      ),
    );
  }

