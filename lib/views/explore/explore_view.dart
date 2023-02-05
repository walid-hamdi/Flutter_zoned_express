import 'package:flutter/material.dart';
import 'package:zoned_express/models/newsletter.dart';
import 'package:zoned_express/widgets/search_box.dart';

import '../../widgets/category_filter.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/scaffold_wrapper.dart';
import 'widgets/newsletter_list.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
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

  List<Newsletter>? _filteredList;

  void _filterNewsletters(String topic) {
    if (topic == "All") {
      return setState(() {
        _filteredList = _newsletters;
      });
    }
    setState(() {
      _filteredList = _newsletters
          .where((newsletter) => newsletter.topic == topic)
          .toList();
    });
  }

  List<String> getTopics() {
    return _newsletters.map((newsletter) => newsletter.topic).toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        child: CustomContainer(
      child: ListView(children: [
        SearchBox(onChanged: _updateSearchTerm),
        const SizedBox(
          height: 10,
        ),
        CategoryFilter(
          categories: ["All", ...getTopics()],
          onCategorySelected: _filterNewsletters,
        ),
        const SizedBox(
          height: 10,
        ),
        NewsletterList(
          searchTerm: _searchTerm,
          newsletters: _filteredList ?? _newsletters,
        ),
        // vertical list of articles
      ]),
    ));
  }
}
