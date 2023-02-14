import 'package:flutter/material.dart';

import '../models/article.dart';
import '../views/article_details/article_details_view.dart';
import 'article_card.dart';

class ArticleList extends StatelessWidget {
  final String? searchTerm;
  final Stream<List<Article>?> articles;

  const ArticleList({
    Key? key,
    this.searchTerm,
    required this.articles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.8,
      width: double.infinity,
      child: StreamBuilder<List<Article>?>(
        stream: articles,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("You don't have articles yet."),
            );
          }

          final articles = snapshot.data;

          return ListView.builder(
            itemCount: articles!.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleDetailsView(
                        article: articles[index],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: ArticleCard(article: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
