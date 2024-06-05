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

  @override
  void initState() {
    super.initState();
    _jokeFuture = _jokesApiClient.fetchRandomJoke();
  }

  // Function to fetch random joke
  Future<void> _fetchRandomJoke() async {
    setState(() {
      _jokeFuture = _jokesApiClient.fetchRandomJoke();
    });
  }

  // Function to save joke
  Future<void> _saveJoke(String joke) async {
    await _dbHelper.insert('jokes', {'joke': joke});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Joke saved successfully')),
    );
  }

  // Function to retrieve saved jokes
  Future<List<String>> _getSavedJokes() async {
    final List<Map<String, dynamic>> jokes = await _dbHelper.queryAll('jokes');
    return jokes.map((joke) => joke['joke'] as String).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Jokes'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<String>(
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
            const Spacer(), // To push the button to the bottom
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
              ),
              onPressed: _fetchRandomJoke,
              child: const Text('Fetch Random Joke'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final savedJokes = await _getSavedJokes();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Saved Jokes'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            savedJokes.map((joke) => Text('* $joke')).toList(),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final joke = await _jokeFuture;
                _saveJoke(joke);
              },
              child: const Text('Save Joke'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
