import 'package:flutter/material.dart';
import 'package:zoned_express/models/newsletter.dart';
import 'package:zoned_express/views/explore/widgets/newsletter_list.dart';
import 'package:zoned_express/widgets/search_box.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/scaffold_wrapper.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({Key? key}) : super(key: key);

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  String? _searchTerm;
  final List<Newsletter> _newsletters = [
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
  void _updateSearchTerm(String value) {
    setState(() {
      _searchTerm = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: CustomAppBar(
        context: context,
        title: "Bookmarks",
        widget: Row(
          children: const [
            Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
            SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
      child: CustomContainer(
          child: ListView(
        children: [
          SearchBox(onChanged: _updateSearchTerm),
          const SizedBox(
            height: 10,
          ),
          NewsletterList(
            searchTerm: _searchTerm,
            newsletters: _newsletters,
          ),
        ],
      )),
    );
  }
}
