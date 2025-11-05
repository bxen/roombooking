import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/staff/staff_home.dart';
import 'package:roombooking/staff/staff_theme.dart';
import 'package:roombooking/screens/home_screen.dart';
import 'package:roombooking/staff/staff_assetlist.dart';
import 'package:roombooking/services/api_client.dart';

class StaffAddroom extends StatefulWidget {
  const StaffAddroom({super.key});

  @override
  State<StaffAddroom> createState() => _StaffAddroomState();
}

class _StaffAddroomState extends State<StaffAddroom> {
  bool isEnabled = true;
  final TextEditingController roomNameController = TextEditingController();

  String? _selectedImagePath;
  bool _submitting = false;

  // ปรับให้ตรงกับ pubspec.yaml ของโปรเจ็กต์คุณ
  static const _assetImages = <String>[
    'images/roomA101.jpg',
    'images/roomA102.jpg',
    'images/roomB201.jpg',
    'images/roomB202.jpg',
    'images/roomC101.jpg',
    'images/roomC102.jpg',
    'images/roomC103.jpg',
    'images/roomscreen.jpg',
  ];

  @override
  void dispose() {
    roomNameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = roomNameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Please enter a room name!',
            style: GoogleFonts.alice(color: Colors.white),
          ),
        ),
      );
      return;
    }
    setState(() => _submitting = true);
    try {
      await api.post(
        '/api/staff/rooms',
        body: {
          'room_name': name,
          'status': isEnabled ? 'free' : 'disabled',
          'image_url': _selectedImagePath,
        },
      );
      if (!mounted) return;
      _showSuccessDialog(context, name);
    } catch (e) {
      if (!mounted) return;
      // ถ้า backend โยน 409 จะถูก map เป็นข้อความใน e
      final msg = e.toString().contains('409')
          ? 'Room name already exists.'
          : 'Create failed: $e';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(msg, style: GoogleFonts.alice(color: Colors.white)),
        ),
      );
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _pickFromAssets() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              itemCount: _assetImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemBuilder: (_, i) {
                final path = _assetImages[i];
                return InkWell(
                  onTap: () {
                    setState(() => _selectedImagePath = path);
                    Navigator.pop(ctx);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(path, fit: BoxFit.cover),
                        if (_selectedImagePath == path)
                          Container(
                            color: Colors.black45,
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5C0000),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Add New Room',
          style: GoogleFonts.alice(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StaffHome()),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () => showStaffLogoutDialog(context),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Room Name',
                  style: GoogleFonts.alice(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: roomNameController,
                  style: GoogleFonts.alice(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'e.g., A101',
                    hintStyle: GoogleFonts.alice(color: Colors.black38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  'Room Image',
                  style: GoogleFonts.alice(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                          image: _selectedImagePath != null
                              ? DecorationImage(
                                  image: AssetImage(_selectedImagePath!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _selectedImagePath == null
                            ? Icon(
                                Icons.image_search,
                                size: 40,
                                color: Colors.grey[600],
                              )
                            : null,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          ElevatedButton(
                            onPressed: _pickFromAssets,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                            ),
                            child: Text(
                              'Pick from Assets',
                              style: GoogleFonts.alice(fontSize: 16),
                            ),
                          ),
                          if (_selectedImagePath != null)
                            TextButton(
                              onPressed: () =>
                                  setState(() => _selectedImagePath = null),
                              child: Text('Clear', style: GoogleFonts.alice()),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SwitchListTile(
                    title: Text(
                      'Room Status',
                      style: GoogleFonts.alice(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      isEnabled ? 'Enabled' : 'Disabled',
                      style: GoogleFonts.alice(
                        color: isEnabled ? Colors.green : Colors.red,
                      ),
                    ),
                    value: isEnabled,
                    activeColor: Colors.green,
                    onChanged: (value) => setState(() => isEnabled = value),
                  ),
                ),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _submitting
                          ? null
                          : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StaffHome(),
                              ),
                            ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.alice(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _submitting ? null : _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _submitting
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Save',
                              style: GoogleFonts.alice(fontSize: 18),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, String roomName) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Center(
            child: Icon(Icons.check_circle, color: Colors.green[700], size: 50),
          ),
          content: Text(
            "Room '$roomName'\nhas been added successfully.",
            textAlign: TextAlign.center,
            style: GoogleFonts.alice(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const StaffAssetList()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: const StadiumBorder(),
              ),
              child: Text('OK', style: GoogleFonts.alice(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

void showStaffLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Are you sure you \nwant to logout?',
          textAlign: TextAlign.center,
          style: GoogleFonts.alice(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (route) => false,
              );
            },
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
      );
    },
  );
}
