import 'package:flutter/material.dart';

import '../../widgets/custom_container.dart';
import '../../widgets/scaffold_wrapper.dart';
import '../../../models/newsletter.dart';
import '../../widgets/label.dart';
import 'widgets/navbar.dart';
import '../../widgets/search_box.dart';
import 'widgets/newsletter_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
      child: CustomContainer(
        child: ListView(
          children: [
            const Navbar(),
            const SizedBox(height: 20),
            SearchBox(
              onChanged: _updateSearchTerm,
            ),
            const Label(
              label: 'Newsletter',
            ),
            NewsletterList(
              searchTerm: _searchTerm,
              newsletters: _newsletters,
            ),
            const Label(
              label: 'Article',
            ),
            // vertical list of articles
            // const ArticleList(),
          ],
        ),
      ),
    );
  }
}
