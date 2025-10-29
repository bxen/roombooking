import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roombooking/screens/home_screen.dart';

class StudentNavbar extends StatelessWidget {
  final String? title;
  final String? leadingText;
  final TextStyle? leadingTextStyle;
  final bool showBack;
  final bool showProfile;
  final double profileIconSize;

  const StudentNavbar({
    super.key,
    this.title,
    this.leadingText,
    this.leadingTextStyle,
    this.showBack = false,
    this.showProfile = true,
    this.profileIconSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildBackOrLeading() {
      if (showBack) {
        return IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        );
      }
      if (leadingText != null) {
        return Text(
          leadingText!,
          style: leadingTextStyle ??
              GoogleFonts.alice(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
        );
      }
      return const SizedBox(width: 48); // balance layout when nothing on left
    }

    Widget buildTitle() {
      return Expanded(
        child: Center(
          child: title != null
              ? Text(
                  title!,
                  style: GoogleFonts.alice(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      );
    }

    Widget buildProfile() {
      if (!showProfile) return const SizedBox(width: 48);
      return IconButton(
        icon: const Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
        iconSize: profileIconSize,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  'Are you sure you \\n+want to logout?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alice(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Logout',
                      style: GoogleFonts.alice(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.alice(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildBackOrLeading(),
        buildTitle(),
        buildProfile(),
      ],
    );
  }
}
