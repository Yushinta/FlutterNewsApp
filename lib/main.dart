import 'package:flutter/material.dart';
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
        '/': (context) => ListNews(),
        '/detailNews': (context) => DetailNews(
            article: ModalRoute.of(context)?.settings.arguments as Article),
      },
      initialRoute: '/',
    );
  }
}
