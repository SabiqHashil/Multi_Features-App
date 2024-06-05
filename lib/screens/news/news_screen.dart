import 'package:flutter/material.dart';
import 'package:multi_app/api/models/news_zone.dart';
import 'package:multi_app/screens/news/news_widget.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider()..fetchNews('technology'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('General News'),
        ),
        body: Center(
          child: Consumer<NewsProvider>(
            builder: (context, newsProvider, child) {
              if (newsProvider.errorMessage != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${newsProvider.errorMessage}',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => newsProvider.fetchNews('technology'),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (newsProvider.news.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: newsProvider.news.length,
                  itemBuilder: (context, index) {
                    final article = newsProvider.news[index];
                    return NewsWidget(
                      title: article.title,
                      description: article.description,
                      url: article.url,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
