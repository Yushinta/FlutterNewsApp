import 'package:flutter/material.dart';
import 'package:flutter_application_news/model/articles.dart';
import 'package:flutter_application_news/provider/news_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

class ListNews extends StatefulWidget {
  const ListNews({super.key});

  @override
  State<ListNews> createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotif() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    await flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(android: initializationSettingsAndroid),
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        final payload = details.payload;
        if (payload != null) {
          print('notification payload: $payload');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initNotif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.articles.length,
              itemBuilder: (context, index) {
                var article = state.result.articles[index];
                return ArticleCard(article: article);
              },
            );
          } else if (state.state == ResultState.noData) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else if (state.state == ResultState.error) {
            return Center(
              child: Material(
                child: Text(state.message),
              ),
            );
          } else {
            return const Center(
              child: Material(
                child: Text(''),
              ),
            );
          }
        },
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(article.title),
      leading: Image.network(
        article.urlToImage!,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      subtitle: Text(article.author!),
      onTap: () {
        Navigator.pushNamed(context, '/detailNews', arguments: article);
      },
    );
  }
}
