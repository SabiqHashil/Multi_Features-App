import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/screens/weather/weather_widget.dart';

class WeatherScreen extends StatefulWidget {
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
        title: Text('Weather Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Weather Information',
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
            else if (_city != null &&
                _temperature != null &&
                _description != null)
              WeatherWidget(
                city: _city!,
                temperature: _temperature!,
                description: _description!,
              )
            else
              Container(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchWeatherData,
              child: Text('Fetch Weather Data'),
            ),
          ],
        ),
      ),
    );
  }
}
