import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/helpers/dbHelper.dart';
import 'package:multi_app/screens/weather/weather_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherApiClient _apiClient = WeatherApiClient();
  String? _city;
  double? _temperature;
  String? _description;
  String? _error;
  bool _isLoading = false;

  // Function to save weather data to local storage
  Future<void> _saveWeatherData() async {
    if (_city != null && _temperature != null && _description != null) {
      await DBHelper.instance.insert('weather', {
        'cityName': _city,
        'temperature': _temperature,
        'description': _description,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Weather data saved')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No weather data to save')),
      );
    }
  }

  // Function to retrieve saved weather data from local storage
  Future<void> _retrieveWeatherData() async {
    List<Map<String, dynamic>> savedData =
        await DBHelper.instance.queryAll('weather');
    // Display popup with saved data
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Saved Weather Data'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: savedData.map((data) {
                return ListTile(
                  title: Text('City: ${data['cityName']}'),
                  subtitle: Text(
                      'Temperature: ${data['temperature']}, Description: ${data['description']}'),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final Map<String, dynamic> data =
          await _apiClient.fetchWeatherData('Kerala');
      setState(() {
        _city = data['location']['name'] as String?;
        _temperature = (data['current']['temp_c'] as double?) ?? 0;
        _description = data['current']['condition']['text'] as String?;
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
        title: const Text('Weather Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            _isLoading
                ? const LinearProgressIndicator() // Simple horizontal loading indicator
                : _error != null
                    ? Text(
                        'Error: $_error',
                        style: const TextStyle(color: Colors.red),
                      )
                    : _city != null &&
                            _temperature != null &&
                            _description != null
                        ? WeatherWidget(
                            city: _city!,
                            temperature: _temperature!,
                            description: _description!,
                          )
                        : Container(),
            const Spacer(), // To push the button to the bottom
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
                      onPressed: _isLoading ? null : _fetchWeatherData,
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
                      onPressed: _isLoading ? null : _saveWeatherData,
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
                      onPressed: _isLoading ? null : _retrieveWeatherData,
                      child: const Text('View Saved'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
