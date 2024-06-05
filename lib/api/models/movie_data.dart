import 'package:multi_app/api/api_response.dart';

class MovieModel {
  final String title;
  final String releaseDate;
  final String description;
  final String imageUrl;

  MovieModel({
    required this.title,
    required this.releaseDate,
    required this.description,
    required this.imageUrl,
  });

  factory MovieModel.fromApiResponse(MovieApiResponse response) {
    return MovieModel(
      title: response.title,
      releaseDate: response.releaseDate,
      description: response.description,
      imageUrl: response.imageUrl,
    );
  }
}
