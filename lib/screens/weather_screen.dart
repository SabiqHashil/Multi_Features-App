import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Screen'),
      ),
      body: Center(
        child: Text(
          'Weather Information',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
