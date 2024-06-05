import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/api/models/movie_data.dart';
import 'package:multi_app/screens/movie/movie_widget.dart';

class MovieScreen extends StatefulWidget {
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
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Search for a Movie',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter movie name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final query = _controller.text;
                  if (query.isNotEmpty) {
                    _fetchMovieData(query);
                  }
                },
                child: Text('Fetch Movie Data'),
              ),
              SizedBox(height: 20),
              if (_isLoading)
                CircularProgressIndicator()
              else if (_error != null)
                Text(
                  'Error: $_error',
                  style: TextStyle(color: Colors.red),
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
