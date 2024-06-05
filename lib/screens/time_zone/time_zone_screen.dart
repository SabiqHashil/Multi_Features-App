import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/helpers/dbHelper.dart';
import 'package:multi_app/screens/time_zone/time_zone_widget.dart';

class TimeZoneScreen extends StatefulWidget {
  const TimeZoneScreen({super.key});

  @override
  _TimeZoneScreenState createState() => _TimeZoneScreenState();
}

class _TimeZoneScreenState extends State<TimeZoneScreen> {
  final TimeZoneApiClient _apiClient = TimeZoneApiClient();
  final DBHelper _dbHelper = DBHelper();
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

  Future<void> _saveTimeZoneData() async {
    if (_timeZone != null && _currentTime != null) {
      Map<String, dynamic> row = {
        'timeZone': _timeZone!,
        'currentTime': _currentTime!,
      };
      await _dbHelper.insert('timezone', row);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Data saved successfully!'),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No data to save!'),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _retrieveTimeZoneData() async {
    List<Map<String, dynamic>> data = await _dbHelper.queryAll('timezone');
    if (data.isNotEmpty) {
      data = data.reversed
          .toList(); // Reverse the order to show the latest data first
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Saved Time Zone Data'),
            content: SingleChildScrollView(
              child: ListBody(
                children: data.map((entry) {
                  return Text(
                      'Time Zone: ${entry['timeZone']}\nCurrent Time: ${entry['currentTime']}\n');
                }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No saved data found!'),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
          duration: const Duration(seconds: 2),
        ),
      );
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
          const Spacer(), // To push the buttons to the bottom

          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      padding: EdgeInsets.zero, // Padding set to zero
                    ),
                    onPressed: _isLoading ? null : _fetchTimeZoneData,
                    child: const Text('Fetch'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      padding: EdgeInsets.zero, // Padding set to zero
                    ),
                    onPressed: _isLoading ? null : _saveTimeZoneData,
                    child: const Text('Save'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding: EdgeInsets.zero, // Padding set to zero
                    ),
                    onPressed: _retrieveTimeZoneData,
                    child: const Text('View Saved'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
