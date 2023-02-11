import 'package:flutter/material.dart';

import '../../../models/article.dart';
import '../../../widgets/cached_image.dart';
import '../../utils/theme/theme_provider.dart';

class ArticleDetailsView extends StatelessWidget {
  final Article article;

  const ArticleDetailsView({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getTheme(context),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 190.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: article.imageUrl,
                  child: CachedNetworkImageWidget(
                    imageUrl: article.imageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 90,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const SizedBox(
                      height: 90,
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 16, left: 16.0, right: 16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      // const SizedBox(height: 16.0),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 8.0, vertical: 4.0),
                      //   decoration: BoxDecoration(
                      //     color: Colors.grey[200],
                      //     borderRadius: BorderRadius.circular(10.0),
                      //   ),
                      //   child: Text(
                      //     "#${article.topic}",
                      //     style: TextStyle(
                      //       fontSize: 12.0,
                      //       color: Colors.blue[700],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 16.0),
                      // Row(
                      //   children: [
                      //     const SizedBox(width: 8.0),
                      //     Container(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 8.0, vertical: 4.0),
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey[200],
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //       child: Text(
                      //         article.writer,
                      //         style: TextStyle(
                      //           fontSize: 12.0,
                      //           color: Colors.blue[700],
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(width: 8.0),
                      //     Container(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 8.0, vertical: 4.0),
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey[200],
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //       child: Text(
                      //         article.readTime,
                      //         style: TextStyle(
                      //           fontSize: 12.0,
                      //           color: Colors.blue[700],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 16.0),
                      Text(
                        article.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
