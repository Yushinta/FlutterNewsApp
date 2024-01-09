import 'package:flutter/material.dart';
import 'package:flutter_application_news/provider/news_provider.dart';
import 'package:flutter_application_news/service/api_service.dart';
import 'package:flutter_application_news/view/web_view_news.dart';
import 'package:provider/provider.dart';
import 'model/articles.dart';
import 'view/detail_news.dart';
import 'view/list_news.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(apiService: ApiService()),
      child: MaterialApp(
        title: 'News App',
        routes: {
          '/': (context) => const ListNews(),
          '/detailNews': (context) => DetailNews(
              article: ModalRoute.of(context)?.settings.arguments as Article),
          '/webNews': (context) => NewsView(
                article: ModalRoute.of(context)?.settings.arguments as Article,
              ),
        },
        initialRoute: '/',
      ),
    );
  }
}
