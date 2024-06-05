import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/api/models/movie_data.dart';
import 'package:multi_app/screens/movie/movie_widget.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
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
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details Search'),
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
