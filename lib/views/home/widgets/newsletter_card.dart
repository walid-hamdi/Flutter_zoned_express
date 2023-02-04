import 'package:flutter/material.dart';

import '../../../models/newsletter.dart';

class NewsletterCard extends StatelessWidget {
  final Newsletter newsletter;

  const NewsletterCard({Key? key, required this.newsletter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 6,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              newsletter.imageUrl,
              height: 90,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    newsletter.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${newsletter.description.substring(0, 40)}...",
                    // style: const TextStyle(overflow: TextOverflow.visible),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          newsletter.readTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          newsletter.writer,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.thumb_up),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.bookmark_border),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.share),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Container(
                            // alignment: Alignment.topLeft,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              newsletter.topic,
                              style: const TextStyle(
                                // fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
