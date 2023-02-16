import 'package:flutter/material.dart';

import '../models/newsletter.dart';
import 'bookmark_card.dart';
import 'newsletter_pdf_viewer.dart';

class BookmarkList extends StatelessWidget {
  final Stream<List<Newsletter>?>? bookmarks;
  final String? searchTerm;

  const BookmarkList({
    Key? key,
    required this.bookmarks,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 265,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<List<Newsletter>?>(
        stream: bookmarks,
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
              child: Text("You haven't add any bookmark yet."),
            );
          }

          final filteredBookmarks = snapshot.data!
              .where((newsletter) => newsletter.title
                  .toLowerCase()
                  .contains(searchTerm?.toLowerCase() ?? ""))
              .toList();

          return ListView.builder(
            itemCount: filteredBookmarks.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => NewsletterDetailsView(
                  //       newsletter: filteredBookmarks[index],
                  //     ),
                  //   ),
                  // );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsletterPdfViewer(
                          newsletter: filteredBookmarks[index]),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: double.infinity,
                  margin: const EdgeInsets.only(right: 8),
                  child: BookmarkCard(
                    bookmark: filteredBookmarks[index],
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
