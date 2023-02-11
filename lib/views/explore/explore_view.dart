import 'package:flutter/material.dart';

import '../../models/article.dart';
import '../../models/newsletter.dart';
import '../../utils/theme/theme_provider.dart';
import '../../widgets/article_list.dart';
import '../../widgets/search_box.dart';
import '../../widgets/category_filter.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/newsletter_list.dart';
import '../../widgets/scaffold_wrapper.dart';
import "../../services/database.dart";

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  String? _searchTerm;
  String? _categoryItem;
  final Stream<List<Newsletter>?> _newslettersStream =
      DatabaseService().newsletters;

  final Stream<List<Article>?> _articlesStream = DatabaseService().articles;

  void _updateSearchTerm(String value) {
    setState(() {
      _searchTerm = value;
    });
  }

  void _categoryItemSelected(String value) {
    setState(() {
      _categoryItem = value;
    });
  }

  Stream<List<String>> _getTopics() {
    return _newslettersStream.map(
      (newsletters) => [
        "All",
        ...newsletters!.map((newsletter) => newsletter.topic).toSet().toList()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getTheme(context),
      child: ScaffoldWrapper(
          child: CustomContainer(
        child: ListView(children: [
          SearchBox(
            onChanged: _updateSearchTerm,
          ),
          const SizedBox(
            height: 10,
          ),
          CategoryFilter(
            categories: _getTopics(),
            onCategorySelected: _categoryItemSelected,
          ),
          const SizedBox(
            height: 10,
          ),
          NewsletterList(
            searchTerm: _searchTerm,
            categoryItem: _categoryItem,
            newsletters: _newslettersStream,
          ),
          const SizedBox(
            height: 20,
          ),
          ArticleList(
            articles: _articlesStream,
          ),
          // vertical list of articles
        ]),
      )),
    );
  }
}
