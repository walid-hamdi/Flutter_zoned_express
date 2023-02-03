import 'package:flutter/material.dart';

import '../../../models/newsletter.dart';
import 'newsletter_card.dart';

class NewsletterList extends StatelessWidget {
  const NewsletterList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Newsletter> newsletters = [
      Newsletter(
        title: "Design Inspiration",
        description: "Get weekly inspiration for designing websites and apps.",
        readTime: "5 min",
        writer: "Jane Doe",
        topic: "Design",
        imageUrl: "https://picsum.photos/300/200",
      ),
      Newsletter(
        title: "Tech News",
        description: "Stay up-to-date on the latest tech news and trends.",
        readTime: "10 min",
        writer: "John Doe",
        topic: "Technology",
        imageUrl: "https://picsum.photos/300/200",
      ),
      Newsletter(
        title: "Marketing Tips",
        description:
            "Learn the latest marketing strategies to grow your business.",
        readTime: "15 min",
        writer: "Jane Smith",
        topic: "Marketing",
        imageUrl: "https://picsum.photos/300/200",
      ),
    ];

    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: newsletters.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 22),
            child: NewsletterCard(newsletter: newsletters[index]),
          );
        },
      ),
    );
  }
}
