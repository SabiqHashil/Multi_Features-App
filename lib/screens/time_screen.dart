import 'package:flutter/material.dart';

class TimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Screen'),
      ),
      body: Center(
        child: Text(
          'Time Information',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
