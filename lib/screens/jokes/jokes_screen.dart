import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/helpers/dbHelper.dart';
import 'package:multi_app/screens/jokes/jokes_widget.dart';

class JokesScreen extends StatefulWidget {
  const JokesScreen({Key? key}) : super(key: key);

  @override
  _JokesScreenState createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  late Future<String> _jokeFuture;
  final JokesApiClient _jokesApiClient = JokesApiClient();
  final DBHelper _dbHelper = DBHelper();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _jokeFuture = _jokesApiClient.fetchRandomJoke();
  }

  // Function to fetch random joke
  Future<void> _fetchRandomJoke() async {
    setState(() {
      _isLoading = true;
      _jokeFuture = _jokesApiClient.fetchRandomJoke();
    });
    await _jokeFuture; // Wait for the joke to be fetched
    setState(() {
      _isLoading = false;
    });
  }

  // Function to save joke
  Future<void> _saveJoke(String joke) async {
    await _dbHelper.insert('jokes', {'joke': joke});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Joke saved successfully!'),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Function to retrieve saved jokes
  Future<List<String>> _getSavedJokes() async {
    final List<Map<String, dynamic>> jokes = await _dbHelper.queryAll('jokes');
    return jokes.reversed
        .map((joke) => joke['joke'] as String)
        .toList(); // Reverse to show the latest first
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Jokes'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder<String>(
                future: _jokeFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    return JokeWidget(snapshot.data!);
                  } else {
                    return const Text('No joke found');
                  }
                },
              ),
            ),
            const Spacer(), // To push the buttons to the bottom
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        padding: EdgeInsets.zero, // Padding set to zero
                      ),
                      onPressed: _isLoading ? null : _fetchRandomJoke,
                      child: const Text('Fetch Joke'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        padding: EdgeInsets.zero, // Padding set to zero
                      ),
                      onPressed: _isLoading
                          ? null
                          : () async {
                              final joke = await _jokeFuture;
                              _saveJoke(joke);
                            },
                      child: const Text('Save Joke'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: EdgeInsets.zero, // Padding set to zero
                      ),
                      onPressed: () async {
                        final savedJokes = await _getSavedJokes();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Saved Jokes'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: savedJokes
                                    .map((joke) => Text('* $joke'))
                                    .toList(),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('View Saved Jokes'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
