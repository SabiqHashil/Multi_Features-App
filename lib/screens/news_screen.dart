import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Screen'),
      ),
      body: Center(
        child: Text(
          'Top News',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
