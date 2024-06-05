import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_app/helpers/dbHelper.dart';

class SavedMoviesScreen extends StatelessWidget {
  const SavedMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dbHelper = DBHelper.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Movies'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: dbHelper.queryAll('movie', orderBy: 'id DESC'),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No saved movies.'));
          } else {
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Column(
                  children: [
                    ListTile(
                      leading: movie['image'] != null
                          ? Image.memory(Uint8List.fromList(movie['image']))
                          : null,
                      title: Text(movie['title']),
                      subtitle: Text(movie['description']),
                      trailing: Text(movie['releaseDate']),
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
