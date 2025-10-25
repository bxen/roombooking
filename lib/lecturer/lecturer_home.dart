import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LecturerHome extends StatefulWidget {
  const LecturerHome({super.key});

  @override
  State<LecturerHome> createState() => _LecturerHomeState();
}

class _LecturerHomeState extends State<LecturerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecturer Home',style: GoogleFonts.alice(color: Colors.white)),
        backgroundColor: Color(0xFF630000),
      ),
      body: Center(
        child: Text(
          'Welcome, Lecturer!',
          style: GoogleFonts.alice(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
    );
  }
}