import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/screens/weather/weather_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
              ),
              onPressed: _isLoading ? null : _fetchWeatherData,
              child: const Text('Fetch Weather Data'),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
