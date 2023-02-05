import 'package:flutter/material.dart';

import '../models/newsletter.dart';
import 'list_card.dart';
import '../views/home/widgets/newsletter_details_view.dart';

class ListBuilder extends StatelessWidget {
  final List<Newsletter> newsletters;
  final bool? vertical;

  const ListBuilder({
    Key? key,
    this.vertical,
    required this.newsletters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 289,
      child: ListView.builder(
        // shrinkWrap: true,
        itemCount: newsletters.length,
        scrollDirection: vertical != null ? Axis.vertical : Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsletterDetailsView(
                    newsletter: newsletters[index],
                  ),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: double.infinity,
              margin: const EdgeInsets.only(right: 8),
              child: ListCard(
                newsletter: newsletters[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
