import 'package:flutter/material.dart';

class JokeWidget extends StatelessWidget {
  final String joke;

  JokeWidget(this.joke);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Text(
        joke,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
