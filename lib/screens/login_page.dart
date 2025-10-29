// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:room_booking/lecturer/lecturer_home.dart';
// import 'package:room_booking/staff/staff_home.dart';
// import 'package:room_booking/student/student_home.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String? _role;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//   Future<void> _login() async {
//     final username = _usernameController.text.trim();
//     final password = _passwordController.text;

//     if (username.isEmpty || password.isEmpty) {
//       _showErrorDialog('Please enter both username and password.');
//       return;
//     }
//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost:3000/login'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'username': username, 'password': password}),
//       );
//        if (response.statusCode == 200) {
//         final data = jsonDecode(response.body) as Map<String, dynamic>;

//         setState(() {
//           _role = data['role'] as String?;
//         });
//         Widget? destination;
//         if (_role == 'lecturer') {
//           destination = const LecturerHome();
//         } else if (_role == 'staff') {
//           destination = const StaffHome();
//         } else if (_role == 'student') {
//           destination = const StudentHome();
//         }
//     if (destination != null) {
//           AwesomeDialog(
//             context: context,
//             dialogType: DialogType.success,
//             animType: AnimType.scale,
//             title: 'Welcome back!',
//             // desc: "You logged in as ${role}",
//             dialogBackgroundColor: Color.fromARGB(
//               255,
//               41,
//               41,
//               41,
//             ), // background colour
//             titleTextStyle: TextStyle(
//               color: Color.fromARGB(255, 190, 230, 130),
//               fontWeight: FontWeight.bold,
//               fontSize: 24,
//             ), // title font colour
//             descTextStyle: TextStyle(
//               color: Color.fromARGB(255, 190, 230, 130),
//             ), // description font colour
//             btnOkOnPress: () {
//               Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (_) => destination!),
//                 (route) => false,
//               );
//             },
//             btnOkColor: Color.fromARGB(255, 190, 230, 130),
//             buttonsTextStyle: TextStyle(
//               color: Colors.black,
//               fontSize: 16,
//             ), // OK button background
//           ).show();
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Unknown role returned from server')),
//           );
//         }
//       } else {
//         final msg = response.body.isEmpty ? 'Login failed' : response.body;
//         _showErrorDialog(msg);
//       }
//     } catch (e) {
//       _showErrorDialog('Login error: $e');
//     }
//   }
//     void _showErrorDialog(String message) async{
//     await showDialog(context: context,
//     builder: (BuildContext context){
//       return const AlertDialog(
//         title: Text('message'),
//         content: Text('data'),
//       );
//     });
//   }

//   Widget build(BuildContext context) {
//         return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 80),
//               Text(
//                 'Hey, \nWelcome \nBack',
//                 style: GoogleFonts.alice(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 100),
//               TextField(
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   hintText: 'Username',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(24),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 style: GoogleFonts.alice(color: Colors.black),
//               ),
//               const SizedBox(height: 16),
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   hintText: 'Password',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(24),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 style: GoogleFonts.alice(color: Colors.black),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 height: 55,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.black,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(24),
//                     ),
//                   ),
//                   onPressed: () {},
//                   child: Text(
//                     "Login",
//                     style: GoogleFonts.alice(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//               ),
//               Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Don’t have an account?",
//                     style: GoogleFonts.alice(color: Colors.white70,fontSize: 16),
//                   ),
//                   TextButton(
//                    onPressed: () => Navigator.pushNamed(context, '/register'),
//                     child: Text(
//                       'SignUp',
//                       style: GoogleFonts.alice(color: Colors.white70,fontSize: 16,fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//     }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:roombooking/config.dart';
import 'dart:convert';

import 'package:roombooking/lecturer/lecturer_home_dashboard.dart';
import 'package:roombooking/staff/staff_home.dart';
import 'package:roombooking/student/student_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _role;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog('Please enter both username and password.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('${AppConfig.baseUrl}/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        setState(() {
          _role = data['role'] as String?;
        });

        Widget? destination;
        if (_role == 'lecturer') {
          destination = const LecturerHomeDashboard();
        } else if (_role == 'staff') {
          destination = const StaffHome();
        } else if (_role == 'student') {
          destination = const StudentHome();
        }
        if (destination != null) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Welcome to room reservation!',
                style: GoogleFonts.alice(
                  // color: Color.fromARGB(255, 190, 230, 130),
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
                    Navigator.of(context).pop(); // ปิด dialog ก่อน
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => destination!),
                      (route) => false,
                    );
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.alice(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unknown role returned from server')),
          );
        }
      } else {
        final msg = response.body.isEmpty ? 'Login failed' : response.body;
        _showErrorDialog(msg);
      }
    } catch (e) {
      _showErrorDialog('Login error: $e');
    }
  }

  void _showErrorDialog(String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
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
