class MovieModel {
  final String title;
  final String director;
  final String releaseDate;

  MovieModel({
    required this.title,
    required this.director,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'],
      director: json['director'] ??
          'Unknown', // Default to 'Unknown' if no director info is available
      releaseDate: json['release_date'],
    );
  }
}
