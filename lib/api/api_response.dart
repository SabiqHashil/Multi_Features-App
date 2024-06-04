class WeatherApiResponse {
  final String cityName;
  final double temperature;
  final String description;

  WeatherApiResponse({
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  factory WeatherApiResponse.fromJson(Map<String, dynamic> json) {
    return WeatherApiResponse(
      cityName: json['name'],
      temperature:
          json['main']['temp'] - 273.15, // Convert from Kelvin to Celsius
      description: json['weather'][0]['description'],
    );
  }
}

class MovieApiResponse {
  final String title;
  final String director;
  final String releaseDate;

  MovieApiResponse({
    required this.title,
    required this.director,
    required this.releaseDate,
  });

  factory MovieApiResponse.fromJson(Map<String, dynamic> json) {
    return MovieApiResponse(
      title: json['title'],
      director: json['director'],
      releaseDate: json['release_date'],
    );
  }
}

class TimeZoneApiResponse {
  final String timeZone;
  final String currentTime;

  TimeZoneApiResponse({
    required this.timeZone,
    required this.currentTime,
  });

  factory TimeZoneApiResponse.fromJson(Map<String, dynamic> json) {
    return TimeZoneApiResponse(
      timeZone: json['data']['time_zone']['id'],
      currentTime: json['data']['time']['datetime'],
    );
  }
}

class NewsApiResponse {
  final String title;
  final String description;
  final String url;

  NewsApiResponse({
    required this.title,
    required this.description,
    required this.url,
  });

  factory NewsApiResponse.fromJson(Map<String, dynamic> json) {
    return NewsApiResponse(
      title: json['title'],
      description: json['description'],
      url: json['url'],
    );
  }
}

class JokesApiResponse {
  final String joke;

  JokesApiResponse({required this.joke});

  factory JokesApiResponse.fromJson(Map<String, dynamic> json) {
    return JokesApiResponse(
      joke: json['value'],
    );
  }
}
