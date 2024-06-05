import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Functionalities App'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildListItem(
            context,
            'Jokes',
            '/jokes',
          ),
          _buildListItem(
            context,
            'News',
            '/news',
          ),
          _buildListItem(
            context,
            'Time Zone',
            '/timezone',
          ),
          _buildListItem(
            context,
            'Weather',
            '/weather',
          ),
          _buildListItem(
            context,
            'Movie',
            '/movie',
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        color: Colors.lightBlueAccent, // Set background color
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
