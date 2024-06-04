import 'package:flutter/material.dart';
import 'screens/common_screen.dart';
import 'screens/weather_screen.dart';
import 'screens/movie_screen.dart';
import 'screens/time_screen.dart';
import 'screens/news_screen.dart';
import 'screens/joke_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Functional App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CommonScreen(),
        '/weather': (context) => WeatherScreen(),
        '/movies': (context) => MovieScreen(),
        '/time': (context) => TimeScreen(),
        '/news': (context) => NewsScreen(),
        '/jokes': (context) => JokeScreen(),
      },
    );
  }
}
