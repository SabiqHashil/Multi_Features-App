import 'package:flutter/material.dart';
import 'package:multi_app/helpers/dbHelper.dart';

class SavedNewsScreen extends StatelessWidget {
  const SavedNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved News'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DBHelper.instance.queryAll('news'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> news =
                List.from(snapshot.data!); // Create a copy of the list
            // Sort the list based on the 'id' field in descending order
            news.sort((a, b) => b['id'].compareTo(a['id']));
            return ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                final article = news[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(article['title']),
                      subtitle: Text(article['description']),
                      onTap: () {
                        // Handle tapping on saved news article
                      },
                    ),
                    const Divider(), // Add a divider after each ListTile
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
