import 'package:flutter/material.dart';
import 'package:multi_app/screens/jokes/jokes_screen.dart';
import 'package:multi_app/screens/main_screen.dart';
import 'package:multi_app/screens/movie/movie_screen.dart';
import 'package:multi_app/screens/news/news_screen.dart';
import 'package:multi_app/screens/time_zone/time_zone_screen.dart';
import 'package:multi_app/screens/weather/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Features App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/weather': (context) => const WeatherScreen(),
        '/movie': (context) => const MovieScreen(),
        '/timezone': (context) => const TimeZoneScreen(),
        '/news': (context) => const NewsScreen(),
        '/jokes': (context) => const JokesScreen(),
      },
    );
  }
}
