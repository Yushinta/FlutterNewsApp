import 'package:flutter/material.dart';
import 'package:flutter_application_news/model/articles.dart';
import 'package:flutter_application_news/service/api_service.dart';

class ListNews extends StatefulWidget {
  const ListNews({super.key});

  @override
  State<ListNews> createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  late Future<ArticlesResult> _article;

  @override
  void initState() {
    super.initState();
    _article = ApiService().topHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
      ),
      body: FutureBuilder(
        future: _article,
        builder: (context, snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  var article = snapshot.data?.articles[index];
                  return ArticleCard(
                    article: article!,
                  );
                },
                itemCount: snapshot.data?.articles.length,
              );
            } else {
              return const Text("");
            }
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
