import 'package:flutter/material.dart';

class MovieWidget extends StatelessWidget {
  final String title;
  final String releaseDate;
  final String description;
  final String imageUrl;

  const MovieWidget({
    super.key,
    required this.title,
    required this.releaseDate,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      color: Colors.grey[300], // Setting background color to grey 200
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: $title',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Release Date: $releaseDate',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              'Description: $description',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            // Check if imageUrl is not null and not empty before displaying the image
            if (imageUrl.isNotEmpty)
              Image.network(
                imageUrl,
                width: double.infinity,
                height: 500,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Image not available');
                },
              )
            else
              const Text('Image not available'),
          ],
        ),
      ),
    );
  }
}
