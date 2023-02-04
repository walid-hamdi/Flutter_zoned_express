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
        imageUrl: "https://picsum.photos/300/200?image=100",
      ),
      Newsletter(
        title: "Tech News",
        description: "Stay up-to-date on the latest tech news and trends.",
        readTime: "10 min",
        writer: "John Doe",
        topic: "Technology",
        imageUrl: "https://picsum.photos/300/200?image=101",
      ),
      Newsletter(
        title: "Marketing Tips",
        description:
            "Learn the latest marketing strategies to grow your business.",
        readTime: "15 min",
        writer: "Jane Smith",
        topic: "Marketing",
        imageUrl: "https://picsum.photos/300/200?image=102",
      ),
    ];

    return SizedBox(
      height: 289,
      child: ListView.builder(
        // shrinkWrap: true,
        itemCount: newsletters.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: double.infinity,
              margin: const EdgeInsets.only(right: 8),
              child: NewsletterCard(newsletter: newsletters[index]));
        },
      ),
    );
  }
}
