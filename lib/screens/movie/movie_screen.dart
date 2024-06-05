import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/api/models/movie_data.dart';
import 'package:multi_app/screens/movie/movie_widget.dart';
import 'package:multi_app/helpers/dbHelper.dart';
import 'package:http/http.dart' as http;
import 'package:multi_app/screens/movie/saved_movies.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final MovieApiClient _apiClient = MovieApiClient();
  MovieModel? _movieData;
  String? _error;
  bool _isLoading = false;

  Future<void> _fetchMovieData(String query) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final MovieModel data = await _apiClient.fetchMovieData(query);
      setState(() {
        _movieData = data;
        _isLoading = false;
      });
      if (_movieData == null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No movie fetched.'),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _saveMovieData() async {
    if (_movieData != null) {
      final dbHelper = DBHelper.instance;
      final imageBytes = await _fetchImageBytes(_movieData!.imageUrl);
      await dbHelper.insert('movie', {
        'title': _movieData!.title,
        'description': _movieData!.description,
        'releaseDate': _movieData!.releaseDate,
        'image': imageBytes,
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Movie saved to local storage.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No movie to save.'),
        ),
      );
    }
  }

  Future<Uint8List?> _fetchImageBytes(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch (e) {
      print('Error fetching image: $e');
    }
    return null;
  }

  void _showSavedMovies() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SavedMoviesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details Search'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.lightGreen),
            onPressed: _saveMovieData,
          ),
          IconButton(
            icon: const Icon(Icons.list, color: Colors.orangeAccent),
            onPressed: _showSavedMovies,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Enter movie name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                ),
                onPressed: () {
                  final query = controller.text;
                  if (query.isNotEmpty) {
                    _fetchMovieData(query);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a movie name.'),
                      ),
                    );
                  }
                },
                child: const Text('Fetch Movie Data'),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_error != null)
                Text(
                  'Error: $_error',
                  style: const TextStyle(color: Colors.red),
                )
              else if (_movieData != null)
                MovieWidget(
                  title: _movieData!.title,
                  releaseDate: _movieData!.releaseDate,
                  description: _movieData!.description,
                  imageUrl: _movieData!.imageUrl,
                )
              else
                Container(),
            ],
          ),
        ),
      ),
    );
  }
}
