import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:roombooking/screens/home_screen.dart';
import 'package:roombooking/staff/staff_home.dart';
import '../services/api_client.dart';

class StaffAssetList extends StatefulWidget {
  const StaffAssetList({super.key});

  @override
  State<StaffAssetList> createState() => _StaffAssetListState();
}

class _StaffAssetListState extends State<StaffAssetList> {
  late Future<List<Map<String, dynamic>>> _rooms;
  final _date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _rooms = _fetch();
  }

  Future<List<Map<String, dynamic>>> _fetch() async {
    final data =
        await api.get(
              '/api/rooms',
              query: {
                'date': _date,
                '_': DateTime.now().millisecondsSinceEpoch, // cache-buster
              },
            )
            as List<dynamic>;
    return data.cast<Map<String, dynamic>>();
  }

  Future<void> _refresh() async {
    setState(() {
      _rooms = _fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5E0B06),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StaffHome()),
          ),
        ),
        title: Text(
          'Manage Rooms',
          style: GoogleFonts.alice(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: _rooms,
            builder: (_, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snap.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snap.error}',
                    style: GoogleFonts.alice(color: Colors.white),
                  ),
                );
              }
              final items = snap.data ?? [];
              if (items.isEmpty) {
                return Center(
                  child: Text(
                    'No rooms',
                    style: GoogleFonts.alice(color: Colors.white),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (_, i) {
                  final r = items[i];
                  final imagePath =
                      (r['image_url'] as String?) ?? 'images/roomA101.jpg';
                  final date = DateTime.now();
                  final timeSlots = (r['timeslots'] as List<dynamic>? ?? [])
                      .cast<Map<String, dynamic>>()
                      .map(
                        (t) => {
                          'time':
                              '${(t['start_time'] as String).substring(0, 5)}–${(t['end_time'] as String).substring(0, 5)}',
                          'status': _displaySlotStatus(t['status'] as String?),
                        },
                      )
                      .toList();

                  return _buildRoomCard(
                    context: context,
                    imagePath: imagePath,
                    roomId: (r['room_id'] as num).toInt(),
                    roomName: r['room_name'] as String,
                    date: date,
                    timeSlots: timeSlots,
                    roomStatus: (r['status'] as String?) ?? 'free',
                    onChanged: _refresh,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  String _displaySlotStatus(String? s) {
    switch ((s ?? '').toLowerCase()) {
      case 'free':
        return 'Free';
      case 'pending':
        return 'Pending';
      case 'disabled':
        return 'Disabled';
      case 'reserved':
      case 'approved':
        return 'Reserved';
      default:
        return 'Free';
    }
  }

  Widget _buildRoomCard({
    required BuildContext context,
    required String imagePath,
    required int roomId,
    required String roomName,
    required List<Map<String, String>> timeSlots,
    required DateTime date,
    required String roomStatus,
    required Future<void> Function() onChanged,
  }) {
    String formattedDate = '${date.day}/${date.month}/${date.year}';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 160,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  roomName,
                  style: GoogleFonts.alice(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Date: $formattedDate',
                  style: GoogleFonts.alice(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: timeSlots.map((slot) {
                    Color color;
                    switch (slot['status']) {
                      case 'Free':
                        color = Colors.green;
                        break;
                      case 'Pending':
                        color = Colors.amber[800]!;
                        break;
                      case 'Disabled':
                        color = Colors.red;
                        break;
                      default:
                        color = Colors.black;
                    }
                    return Text(
                      '${slot['time']}  ${slot['status']}',
                      style: GoogleFonts.alice(fontSize: 16, color: color),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showEditDialog(
                        context,
                        roomId,
                        roomName,
                        imagePath,
                        onChanged,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        'EDIT',
                        style: GoogleFonts.alice(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _showDisableDialog(
                        context,
                        roomId,
                        roomName,
                        roomStatus,
                        onChanged,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: const StadiumBorder(),
                      ),
                      child: Text(
                        roomStatus == 'disabled' ? 'Enable' : 'Disable',
                        style: GoogleFonts.alice(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    int roomId,
    String roomName,
    String currentImagePath,
    Future<void> Function() onChanged,
  ) {
    final TextEditingController nameController = TextEditingController(
      text: roomName,
    );
    String? selectedImagePath = currentImagePath;

    showDialog(
      context: context,
      builder: (dialogContext) {
        bool saving = false;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            Future<void> save() async {
              setState(() { saving = true; });
              try {
                await api.patch(
                  '/api/staff/rooms/$roomId',
                  body: {
                    'room_name': nameController.text.trim(),
                    'image_url': selectedImagePath,
                  },
                );
                if (!mounted) return;
                Navigator.pop(dialogContext);
                await onChanged(); // รอให้หน้า list โหลดใหม่จริง ๆ ก่อนจบ
              } catch (e) {
                setState(() => saving = false);
                final msg = e.toString().contains('409')
                    ? 'Room name already exists'
                    : 'Update failed: $e';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      msg,
                      style: GoogleFonts.alice(color: Colors.white),
                    ),
                  ),
                );
              }
            }

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Center(
                child: Text(
                  'EDIT',
                  style: GoogleFonts.alice(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.alice(color: Colors.black),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                            image: selectedImagePath != null
                                ? DecorationImage(
                                    image: AssetImage(selectedImagePath!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: selectedImagePath == null
                              ? Icon(
                                  Icons.image,
                                  size: 40,
                                  color: Colors.grey[600],
                                )
                              : null,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onPressed: () => setState(
                            () => selectedImagePath = 'images/roomA102.jpg',
                          ),
                          child: Text(
                            'Upload Image',
                            style: GoogleFonts.alice(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                          ),
                          onPressed: saving ? null : save,
                          child: saving
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Save',
                                  style: GoogleFonts.alice(color: Colors.white),
                                ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                          ),
                          onPressed: () => Navigator.pop(dialogContext),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.alice(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDisableDialog(
    BuildContext context,
    int roomId,
    String roomName,
    String roomStatus,
    Future<void> Function() onChanged,
  ) {
    final toDisable = roomStatus != 'disabled';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Text(
            toDisable ? 'Disable this room?' : 'Enable this room?',
            style: GoogleFonts.alice(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        content: Text(
          toDisable
              ? 'Are you sure you want to disable $roomName?'
              : 'Are you sure you want to enable $roomName?',
          textAlign: TextAlign.center,
          style: GoogleFonts.alice(
            fontSize: 16,
            color: toDisable ? Colors.red : Colors.green,
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: Colors.grey[400]!),
              shape: const StadiumBorder(),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.alice(color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              onChanged();
              try {
                await api.patch(
                  '/api/staff/rooms/$roomId',
                  body: {'status': toDisable ? 'disabled' : 'free'},
                );

                _showSuccessDialog(
                  context,
                  roomName,
                  toDisable ? 'disabled' : 'enabled',
                );
                await onChanged(); // รอให้หน้า list โหลดใหม่
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      'Failed: $e',
                      style: GoogleFonts.alice(color: Colors.white),
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: toDisable ? Colors.red[700] : Colors.green[700],
              shape: const StadiumBorder(),
            ),
            child: Text(
              'Confirm',
              style: GoogleFonts.alice(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(
    BuildContext context,
    String roomName,
    String action,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Center(
          child: Icon(Icons.check_circle, color: Colors.green[700], size: 50),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "'$roomName'\nhas been $action successfully.",
              textAlign: TextAlign.center,
              style: GoogleFonts.alice(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: const StadiumBorder(),
              ),
              child: Text('OK', style: GoogleFonts.alice(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Are you sure you \nwant to logout?',
          textAlign: TextAlign.center,
          style: GoogleFonts.alice(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: const StadiumBorder(),
            ),
            child: Text(
              'Logout',
              style: GoogleFonts.alice(color: Colors.white, fontSize: 15),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.alice(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
