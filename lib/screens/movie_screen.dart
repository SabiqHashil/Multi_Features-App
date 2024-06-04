import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Screen'),
      ),
      body: Center(
        child: Text(
          'Top Movies',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
