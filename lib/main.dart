import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';

void main() {
  runApp(const RoomReservationApp());
}

class RoomReservationApp extends StatelessWidget {
  const RoomReservationApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Reservation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF630000)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF630000),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },

    );
  }
}