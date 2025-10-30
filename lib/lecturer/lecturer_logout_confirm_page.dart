import 'package:flutter/material.dart';
import 'lecturer_theme.dart';
import 'lecturer_widgets.dart'; // ใช้ showLecturerLogoutDialog

class LecturerLogoutConfirmPage extends StatefulWidget {
  const LecturerLogoutConfirmPage({super.key});

  @override
  State<LecturerLogoutConfirmPage> createState() => _LecturerLogoutConfirmPageState();
}

class _LecturerLogoutConfirmPageState extends State<LecturerLogoutConfirmPage> {
  @override
  void initState() {
    super.initState();
    // เปิด dialog ทันทีที่หน้าพร้อม
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showLecturerLogoutDialog(context);
      if (mounted) Navigator.pop(context); // ปิดหน้านี้ถ้า user กดยกเลิก
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: LecturerTheme.theme(),
      child: const Scaffold(
        // ไม่ต้องมีอะไร แค่พื้นหลังรองไว้ให้เปิด dialog
        body: SizedBox.shrink(),
      ),
    );
  }
}
