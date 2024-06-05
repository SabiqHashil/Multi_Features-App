import 'package:flutter/material.dart';

class JokeWidget extends StatelessWidget {
  final String joke;

  const JokeWidget(this.joke, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300], // Light blue background color
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          joke,
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
