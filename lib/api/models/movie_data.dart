

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

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'] ?? 'Unknown Title',
      releaseDate: json['release_date'] ?? 'Unknown Release Date',
      description: json['overview'] ?? 'No Description Available',
      imageUrl: 'https://image.tmdb.org/t/p/w500${json['poster_path']}' ?? '',
    );
  }
}
