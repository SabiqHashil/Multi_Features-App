import 'package:flutter/material.dart';

class CommonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Common Screen'),
      ),
      body: Center(
        child: Text(
          'Top Responses from all APIs',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
