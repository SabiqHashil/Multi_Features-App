import 'package:flutter/material.dart';

class JokeWidget extends StatelessWidget {
  final String joke;

  JokeWidget(this.joke);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(joke),
    );
  }
}
