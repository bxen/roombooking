import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StdbookingPage extends StatefulWidget {
  final String roomName;
  final String status;
  final String imagePath;
  final List<String> timeSlots;


  const StdbookingPage({
    super.key,
    required this.roomName,
    required this.status,
    required this.imagePath,
    required this.timeSlots,
  });

  @override
  State<StdbookingPage> createState() => _StdbookingPageState();
}

class _StdbookingPageState extends State<StdbookingPage> {
  String? selectedObjective;
  String? selectedTime;

  final List<String> objectives = [
    'Presentation practice',
    'Group Study',
    'Meeting',
    'Research/Assignment',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F5F0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.asset(
                        widget.imagePath,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  widget.roomName,
                                  style: GoogleFonts.alice(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  'Status: Free',
                                  style: GoogleFonts.alice(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              //dropdown list objective
                              Text(
                                'Objective:',
                                style: GoogleFonts.alice(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                value: selectedObjective,
                                hint: const Text('Select objective'),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                ),
                                items: objectives.map((obj) {
                                  return DropdownMenuItem(
                                    value: obj,
                                    child: Text(obj),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedObjective = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),

                              //dropdown list Timeslots
                              Text(
                                'Time:',
                                style: GoogleFonts.alice(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              DropdownButtonFormField<String>(
                                value: selectedTime,
                                hint: const Text('Select time slot'),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[300],
                                  border: InputBorder.none,
                                ),
                                items: widget.timeSlots
                                    .map(
                                      (time) => DropdownMenuItem(
                                        value: time,
                                        child: Text(time),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedTime = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 30),

                              //confirm booking button
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (selectedObjective != null &&
                                        selectedTime != null) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: const Color(
                                              0xFFF8F5F0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            title: Center(
                                              child: Text(
                                                'Are you sure you want \nto book this room?',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.alice(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   'Time Slots ${date.day}/${date.month}/${date.year}',
                                                //   style: GoogleFonts.alice(
                                                //     color: Colors.red,
                                                //     fontSize: 18,
                                                //   ),
                                                // ),
                                                Text(
                                                  'Time: $selectedTime',
                                                  style: GoogleFonts.alice(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  'Objective: $selectedObjective',
                                                  style: GoogleFonts.alice(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  'Once confirmed, the request will be sent for approval.',
                                                  style: GoogleFonts.alice(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.center,
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
                                                child: Text('Confirm',style: TextStyle(color: Colors.white),),
                                              ),

                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel',style: TextStyle(color: Colors.black),),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: const StadiumBorder(),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 12,
                                    ),
                                  ),
                                  child: Text(
                                    'Confirm Booking',
                                    style: GoogleFonts.alice(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
