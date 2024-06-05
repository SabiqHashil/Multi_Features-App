import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/screens/time_zone/time_zone_widget.dart';

class TimeZoneScreen extends StatefulWidget {
  const TimeZoneScreen({super.key});

  @override
  _TimeZoneScreenState createState() => _TimeZoneScreenState();
}

class _TimeZoneScreenState extends State<TimeZoneScreen> {
  final TimeZoneApiClient _apiClient = TimeZoneApiClient();
  String? _timeZone;
  String? _currentTime;
  String? _error;
  bool _isLoading = false;

  Future<void> _fetchTimeZoneData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final data = await _apiClient.fetchTimeZoneData('Asia/Kolkata');
      setState(() {
        _timeZone = 'Asia/Kolkata';
        _currentTime = data['dateTime'];
        _error = null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Date and Time Zone'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: _timeZone != null && _currentTime != null
                ? TimeZoneWidget(
                    timeZone: _timeZone!,
                    currentTime: _currentTime!,
                  )
                : _isLoading
                    ? const CircularProgressIndicator()
                    : _error != null
                        ? Text(
                            'Error: $_error',
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox(), // Placeholder if no data fetched yet
          ),
          const Spacer(), // To push the button to the bottom

          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: EdgeInsets.zero, // Padding set to zero
              ),
              onPressed: _isLoading ? null : _fetchTimeZoneData,
              child: const Text('Fetch Time Zone Data'),
            ),
          ),
        ],
      ),
    );
  }
}
