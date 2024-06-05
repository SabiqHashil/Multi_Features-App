import 'package:flutter/material.dart';
import 'package:multi_app/api/models/news_zone.dart';
import 'package:multi_app/screens/news/news_widget.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider()..fetchNews('technology'),
      child: Scaffold(
        appBar: AppBar(
          title: Text('News Screen'),
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
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => newsProvider.fetchNews('technology'),
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (newsProvider.news.isEmpty) {
                return Center(child: CircularProgressIndicator());
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
