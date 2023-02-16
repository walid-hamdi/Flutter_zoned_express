import 'package:flutter/material.dart';

import '../models/newsletter.dart';
import 'newsletter_card.dart';
import 'newsletter_pdf_viewer.dart';

class NewsletterList extends StatelessWidget {
  final Stream<List<Newsletter>?> newsletters;
  final String? searchTerm;
  final String? categoryItem;

  const NewsletterList({
    Key? key,
    required this.newsletters,
    required this.searchTerm,
    this.categoryItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 265,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<List<Newsletter>?>(
        stream: newsletters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: Text('No network connection. Please try again later.'),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text("You don't have newsletters now."),
            );
          }

// filter by search term
          var filteredNewsletters = snapshot.data!
              .where((newsletter) => newsletter.title
                  .toLowerCase()
                  .contains(searchTerm?.toLowerCase() ?? ""))
              .toList();
// filter by category select item
          if (categoryItem != "All" && categoryItem != null) {
            filteredNewsletters = snapshot.data!
                .where(
                  (newsletter) => newsletter.topic == categoryItem,
                )
                .toList();
          }

          return ListView.builder(
            // shrinkWrap: true,
            itemCount: filteredNewsletters.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => NewsletterDetailsView(
                  //       newsletter: filteredNewsletters[index],
                  //     ),
                  //   ),
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsletterPdfViewer(
                        newsletter: filteredNewsletters[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: double.infinity,
                  margin: const EdgeInsets.only(right: 8),
                  child: NewsletterCard(
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
