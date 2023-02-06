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
      description:
          "Get weekly inspiration for designing websites and apps. Discover the latest design trends, tips, and tricks for creating visually appealing and user-friendly designs. Whether you're a beginner or a seasoned designer, this newsletter is a must-read for staying up-to-date on the latest design industry news. Get weekly inspiration for designing websites and apps. Discover the latest design trends, tips, and tricks for creating visually appealing and user-friendly designs. Whether you're a beginner or a seasoned designer, this newsletter is a must-read for staying up-to-date on the latest design industry news.",
      readTime: "5 min",
      writer: "Jane Doe",
      topic: "Design",
      imageUrl: "https://picsum.photos/300/200?image=100",
    ),
    Newsletter(
      title: "Tech News",
      description:
          "Stay up-to-date on the latest tech news and trends. From groundbreaking new technologies to emerging startups, this newsletter covers it all. Get insights into the future of tech and stay ahead of the curve with the latest updates and analysis.",
      readTime: "10 min",
      writer: "John Doe",
      topic: "Technology",
      imageUrl: "https://picsum.photos/300/200?image=101",
    ),
    Newsletter(
      title: "Marketing Tips",
      description:
          "Learn the latest marketing strategies to grow your business. Whether you're looking to improve your SEO, increase conversions, or simply get more traffic, this newsletter is packed with actionable tips and advice to help you achieve your marketing goals.",
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
            const SizedBox(
              height: 10,
            ),
            const Navbar(),
            const SizedBox(height: 22),
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
