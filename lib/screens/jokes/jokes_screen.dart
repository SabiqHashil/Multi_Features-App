import 'package:flutter/material.dart';

class JokesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes'),
      ),
      body: Center(
        child: Text('Display jokes here'),
      ),
    );
  }
}
