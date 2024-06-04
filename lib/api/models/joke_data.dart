class JokesModel {
  final String joke;

  JokesModel({required this.joke});

  factory JokesModel.fromJson(Map<String, dynamic> json) {
    return JokesModel(
      joke: json['value'],
    );
  }
}
