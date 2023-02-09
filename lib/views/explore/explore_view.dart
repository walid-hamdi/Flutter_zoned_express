import 'package:flutter/material.dart';

import '../../models/article.dart';
import '../../models/newsletter.dart';
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
  final Stream<List<Newsletter>?> _newslettersStream =
      DatabaseService().newsletters;

  final Stream<List<Article>?> _articlesStream = DatabaseService().articles;

  void _updateSearchTerm(String value) {
    setState(() {
      _searchTerm = value;
    });
  }

  Stream<List<Newsletter>?>? _filteredStreamList;

  void _filterNewsletters(String topic) {
    if (topic == "All") {
      return setState(() {
        _filteredStreamList = _newslettersStream;
      });
    }

    setState(() {
      _filteredStreamList = _newslettersStream.map(
        (newsletters) => newsletters
            ?.where((newsletter) => newsletter.topic == topic)
            .toList(),
      );
    });
  }

  Stream<List<String>> getTopics() {
    return _newslettersStream.map(
      (newsletters) => [
        "All",
        ...newsletters!.map((newsletter) => newsletter.topic).toSet().toList()
      ],
    );
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
          categories: getTopics(),
          onCategorySelected: _filterNewsletters,
        ),
        const SizedBox(
          height: 10,
        ),
        NewsletterList(
          searchTerm: _searchTerm,
          newsletters: _filteredStreamList ?? _newslettersStream,
        ),
        const SizedBox(
          height: 20,
        ),
        ArticleList(
          articles: _articlesStream,
        ),
        // vertical list of articles
      ]),
    ));
  }
}




// in home view :
// 1- when refresh refresh icon appear to refresh all connections
// 2- add the ability to like, add to bookmark, or share
// 3- add article list with all functionalities
// 4- handle notification icon to inform the new change

// in explore view:
// 1- fix filter by category
// 2- add article list

  //  in bookmark
  // 1- show all bookmarks related to that specific user
  // 2- ability to remove all bookmarks or one bookmark

// in profile view
// 1- show all user auth info
// 2- show all login / register views if the user logout
// 3- add settings view to change user info / theme of the app
