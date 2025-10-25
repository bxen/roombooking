import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffHome extends StatefulWidget {
  const StaffHome({super.key});

  @override
  State<StaffHome> createState() => _StaffHomeState();
}

class _StaffHomeState extends State<StaffHome> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Staff Home',style: GoogleFonts.alice(color: Colors.white)),
        backgroundColor:  Color(0xFF630000),
      ),
      body: Center(
        child: Text(
          'Welcome, Staff!',
          style: GoogleFonts.alice(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
    );
  }
}