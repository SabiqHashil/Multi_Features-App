import 'package:flutter/material.dart';

class MovieWidget extends StatelessWidget {
  final String title;
  final String releaseDate;
  final String description;
  final String imageUrl;

  MovieWidget({
    required this.title,
    required this.releaseDate,
    required this.description,
    required this.imageUrl,
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
              'Release Date: $releaseDate',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Description: $description',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            // Check if imageUrl is not null and not empty before displaying the image
            if (imageUrl.isNotEmpty)
              Image.network(
                imageUrl,
                width: double.infinity,
                height: 500,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Text('Image not available');
                },
              )
            else
              Text('Image not available'),
          ],
        ),
      ),
    );
  }
}
