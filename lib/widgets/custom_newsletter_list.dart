import 'package:flutter/material.dart';

import '../models/newsletter.dart';
import 'custom_list_card.dart';
import '../views/newsletter_details/newsletter_details_view.dart';

class NewsletterList extends StatelessWidget {
  final Stream<List<Newsletter>?> newsletters;
  final String? searchTerm;
  final bool? vertical;

  const NewsletterList({
    Key? key,
    this.vertical,
    required this.newsletters,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 289,
      child: StreamBuilder<List<Newsletter>?>(
        stream: newsletters,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final filteredNewsletters = snapshot.data!
              .where((newsletter) => newsletter.title
                  .toLowerCase()
                  .contains(searchTerm?.toLowerCase() ?? ""))
              .toList();

          return ListView.builder(
            // shrinkWrap: true,
            itemCount: filteredNewsletters.length,
            scrollDirection: vertical != null ? Axis.vertical : Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsletterDetailsView(
                        newsletter: filteredNewsletters[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: double.infinity,
                  margin: const EdgeInsets.only(right: 8),
                  child: ListCard(
                    newsletter: filteredNewsletters[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
