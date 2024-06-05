import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Functionalities App'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jokes');
              },
              child: const Text('Jokes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/news');
              },
              child: const Text('News'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/timezone');
              },
              child: const Text('Time Zone'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather');
              },
              child: const Text('Weather'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/movie');
              },
              child: const Text('Movie'),
            ),
          ],
        ),
      ),
    );
  }
}
