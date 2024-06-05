import 'package:flutter/material.dart';

class TimeZoneWidget extends StatelessWidget {
  final String timeZone;
  final String currentTime;

  const TimeZoneWidget({super.key, 
    required this.timeZone,
    required this.currentTime,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Adjust this value as needed
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(10),
        color: Colors.grey[300], // Setting background color to grey 200
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Time Zone: $timeZone',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Flexible(
                child: Text(
                  'Current Date and Time: $currentTime',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
