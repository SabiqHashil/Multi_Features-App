import 'package:flutter/material.dart';
import 'package:multi_app/api/api_client.dart';
import 'package:multi_app/api/models/news_zone.dart';
import 'news_widget.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<NewsModel>> _newsFuture;
  final NewsApiClient _newsApiClient = NewsApiClient();

  @override
  void initState() {
    super.initState();
    _newsFuture =
        _newsApiClient.fetchNewsData('technology'); // Change category as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'News Updates',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _newsFuture = _newsApiClient.fetchNewsData('technology');
                });
              },
              child: Text('Fetch News Updates'),
            ),
            Expanded(
              child: FutureBuilder<List<NewsModel>>(
                future: _newsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<NewsModel> articles = snapshot.data!;
                    return ListView.builder(
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return NewsWidget(
                          title: articles[index].title,
                          description: articles[index].description,
                          url: articles[index].url,
                        );
                      },
                    );
                  } else {
                    return Text('No news found');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
