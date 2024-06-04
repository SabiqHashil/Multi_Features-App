import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Functionalities App'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/jokes');
              },
              child: Text('Jokes'),
            ),
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
          ],
        ),
      ),
    );
  }
}
