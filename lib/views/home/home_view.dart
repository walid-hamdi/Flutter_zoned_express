import 'package:flutter/material.dart';

import '../../models/newsletter.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/scaffold_wrapper.dart';
import '../../widgets/custom_label.dart';
// import 'widgets/article_list.dart';
import 'widgets/navbar.dart';
import '../../widgets/custom_search_box.dart';
import '../../widgets/custom_newsletter_list.dart';
import "../../services/database.dart";

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? _searchTerm;
  final Stream<List<Newsletter>?> _newslettersStream =
      DatabaseService().newsletters;

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
              label: 'Newsletters',
            ),
            NewsletterList(
              searchTerm: _searchTerm,
              newsletters: _newslettersStream,
            ),
            const Label(
              label: 'Articles',
            ),
            // ArticleList(
            //   searchTerm: _searchTerm,
            //   newsletters: _newsletters,
            // ),
          ],
        ),
      ),
    );
  }
}
