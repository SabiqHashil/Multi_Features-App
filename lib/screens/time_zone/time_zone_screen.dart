import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/screens/time_zone/time_zone_widget.dart';

class TimeZoneScreen extends StatefulWidget {
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
      final data = await _apiClient.fetchTimeZoneData('Europe/Amsterdam');
      setState(() {
        _timeZone = 'Europe/Amsterdam';
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
        title: Text('Time Zone Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time Zone Data',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (_isLoading)
              CircularProgressIndicator()
            else if (_error != null)
              Text(
                'Error: $_error',
                style: TextStyle(color: Colors.red),
              )
            else if (_timeZone != null && _currentTime != null)
              TimeZoneWidget(
                timeZone: _timeZone!,
                currentTime: _currentTime!,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchTimeZoneData,
              child: Text('Fetch Time Zone Data'),
            ),
          ],
        ),
      ),
    );
  }
}
