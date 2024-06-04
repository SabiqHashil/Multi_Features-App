import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather');
              },
              child: Text('Weather'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/movie');
              },
              child: Text('Movie'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/timezone');
              },
              child: Text('Time Zone'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/news');
              },
              child: Text('News'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jokes');
              },
              child: Text('Jokes'),
            ),
          ],
        ),
      ),
    );
  }
}
