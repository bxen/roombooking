import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('Student Home',style: GoogleFonts.alice(color: Colors.white)),
        backgroundColor: Color(0xFF630000),
      ),
      body: Center(
        child: Text(
          'Welcome, Student!',
          style: GoogleFonts.alice(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
        ),
      ),
    );
  }
}