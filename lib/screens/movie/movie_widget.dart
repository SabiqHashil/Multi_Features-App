import 'package:flutter/material.dart';

class MovieWidget extends StatelessWidget {
  final String title;
  final String director;
  final String releaseDate;

  MovieWidget({
    required this.title,
    required this.director,
    required this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: $title',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Director: $director',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Release Date: $releaseDate',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
