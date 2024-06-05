import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/screens/jokes/jokes_widget.dart';

class JokesScreen extends StatefulWidget {
  const JokesScreen({super.key});

  @override
  _JokesScreenState createState() => _JokesScreenState();
}

class _JokesScreenState extends State<JokesScreen> {
  late Future<String> _jokeFuture;
  final JokesApiClient _jokesApiClient = JokesApiClient();

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
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
