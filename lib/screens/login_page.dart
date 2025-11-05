import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import '../config.dart';
import '../services/api_client.dart';
import '../services/session.dart';

import '../lecturer/lecturer_home.dart';
import '../staff/staff_home.dart';
import '../student/student_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    if (username.isEmpty || password.isEmpty) {
      return _showErrorDialog('Please enter both username and password.');
    }

    try {
      final data =
          await api.post(
                '/login',
                body: {'username': username, 'password': password},
              )
              as Map<String, dynamic>;
      // data = { uid, username, role }
      Session.userId = (data['uid'] as num).toInt();
      Session.role = data['role'] as String;

      Widget? destination;
      switch (Session.role) {
        case 'lecturer':
          destination = const LecturerHome();
          break;
        case 'staff':
          destination = const StaffHome();
          break;
        case 'student':
          destination = const StudentHome();
          break;
      }

      if (destination != null) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Welcome to room reservation!',
              style: GoogleFonts.alice(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            content: Text(
              'You have successfully logged in',
              style: GoogleFonts.alice(fontSize: 16),
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => destination!),
                    (_) => false,
                  );
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.alice(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      } else {
        _showErrorDialog('Unknown role');
      }
    } catch (e) {
      _showErrorDialog('Login failed: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Text(
                'Hey, \nWelcome \nBack',
                style: GoogleFonts.alice(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 100),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: GoogleFonts.alice(color: Colors.black),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: GoogleFonts.alice(color: Colors.black),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: _login,
                  child: Text(
                    "Login",
                    style: GoogleFonts.alice(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account?",
                    style: GoogleFonts.alice(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text(
                      'SignUp',
                      style: GoogleFonts.alice(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
