import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:multi_app/api/models/news_zone.dart';
import 'dart:io';
import 'package:retry/retry.dart';

// class WeatherApiClient {
//   static const String apiKey = 'YOUR_API_KEY';
//   static const String baseUrl =
//       'https://api.openweathermap.org/data/2.5/weather';

//   Future<Map<String, dynamic>> fetchWeatherData(String cityName) async {
//     final response = await http.get('$baseUrl?q=$cityName&appid=$apiKey');
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load weather data');
//     }
//   }
// }

// class MovieApiClient {
//   static const String apiKey = 'YOUR_API_KEY';
//   static const String baseUrl = 'https://api.themoviedb.org/3';

//   Future<Map<String, dynamic>> fetchMovieData(String query) async {
//     final response =
//         await http.get('$baseUrl/search/movie?api_key=$apiKey&query=$query');
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load movie data');
//     }
//   }
// }

// class TimeZoneApiClient {
//   static const String apiKey = 'YOUR_API_KEY';
//   static const String baseUrl = 'https://timezoneapi.io/api';

//   Future<Map<String, dynamic>> fetchTimeZoneData(String location) async {
//     final response =
//         await http.get('$baseUrl/zone?location=$location&token=$apiKey');
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Failed to load time zone data');
//     }
//   }
// }

// class NewsApiClient {
//   static const String apiKey =
//       'e2597e2fe2cb4c98a79e3b120f8a760e'; // Use your own API key
//   static const String baseUrl = 'https://newsapi.org/v2';
//   static const String category = 'technology';

//   Future<List<NewsModel>> fetchNewsData(String category) async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'),
//     );
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       final List<dynamic> articles = data['articles'];
//       return articles.map((article) => NewsModel.fromJson(article)).toList();
//     } else {
//       throw Exception('Failed to load news data');
//     }
//   }
// }

class NewsApiClient {
  static const String apiKey =
      'e2597e2fe2cb4c98a79e3b120f8a760e'; // Use your own API key
  static const String baseUrl = 'https://newsapi.org/v2';
  static const String defaultCategory = 'technology';

  Future<List<NewsModel>> fetchNewsData(
      {String category = defaultCategory}) async {
    final r = RetryOptions(maxAttempts: 3);

    try {
      final response = await r.retry(
        () => http
            .get(Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'))
            .timeout(Duration(seconds: 5)),
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];
        return articles.map((article) => NewsModel.fromJson(article)).toList();
      } else {
        throw Exception('Failed to load news data: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      print('SocketException: $e');
      throw Exception(
          'Failed to load news data. Please check your internet connection.');
    } on TimeoutException catch (e) {
      print('TimeoutException: $e');
      throw Exception(
          'Failed to load news data. The request timed out. Please try again.');
    } on HttpException catch (e) {
      print('HttpException: $e');
      throw Exception('Failed to load news data. HTTP error occurred.');
    } on FormatException catch (e) {
      print('FormatException: $e');
      throw Exception('Failed to load news data. Response format is invalid.');
    } catch (e) {
      print('Unknown error: $e');
      throw Exception('Failed to load news data due to an unknown error.');
    }
  }
}

class JokesApiClient {
  static const String baseUrl =
      'https://official-joke-api.appspot.com/random_joke';

  Future<String> fetchRandomJoke() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return "${data['setup']} - ${data['punchline']}";
    } else {
      throw Exception('Failed to load joke');
    }
  }
}
