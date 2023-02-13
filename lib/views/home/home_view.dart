import 'package:flutter/material.dart';

import '../../models/article.dart';
import '../../models/newsletter.dart';
import '../../services/firebase/database.dart';
import '../../utils/theme/theme_provider.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/scaffold_wrapper.dart';
import '../../widgets/label.dart';
import '../../widgets/article_list.dart';
import 'widgets/navbar.dart';
import '../../widgets/search_box.dart';
import '../../widgets/newsletter_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? _searchTerm;

  final Stream<List<Newsletter>?> _newslettersStream =
      DatabaseService().newsletters;

  final Stream<List<Article>?> _articlesStream = DatabaseService().articles;

  void _updateSearchTerm(String value) {
    setState(() {
      _searchTerm = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getTheme(context),
      child: ScaffoldWrapper(
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
              ArticleList(
                articles: _articlesStream,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
