import 'package:flutter/material.dart';

class JokeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Screen'),
      ),
      body: Center(
        child: Text(
          'Jokes',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
