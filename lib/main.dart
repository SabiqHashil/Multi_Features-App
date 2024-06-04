import 'package:flutter/material.dart';
import 'package:multi_app/screens/jokes/jokes_screen.dart';
import 'package:multi_app/screens/main_screen.dart';
import 'package:multi_app/screens/movie/movie_screen.dart';
import 'package:multi_app/screens/news/news_screen.dart';
import 'package:multi_app/screens/time_zone/time_zone_screen.dart';
import 'package:multi_app/screens/weather/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-functional App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/weather': (context) => WeatherScreen(),
        '/movie': (context) => MovieScreen(),
        '/timezone': (context) => TimeZoneScreen(),
        '/news': (context) => NewsScreen(),
        '/additional': (context) => JokesScreen(),
      },
    );
  }
}
