import 'package:flutter/material.dart';
import 'package:flutter_application_news/view/web_view_news.dart';
import 'model/articles.dart';
import 'view/detail_news.dart';
import 'view/list_news.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
