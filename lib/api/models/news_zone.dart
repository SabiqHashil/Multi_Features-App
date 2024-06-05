import 'package:flutter/foundation.dart';
import 'package:multi_app/api/api_client.dart';

class NewsModel {
  final String title;
  final String description;
  final String url;

  NewsModel({
    required this.title,
    required this.description,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
    );
  }
}

class NewsProvider with ChangeNotifier {
  final NewsApiClient _newsApiClient = NewsApiClient();
  List<NewsModel> _news = [];
  String? _errorMessage;

  List<NewsModel> get news => _news;
  String? get errorMessage => _errorMessage;

  Future<void> fetchNews(String category) async {
    try {
      _news = await _newsApiClient.fetchNewsData(category);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}