import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/newsletter.dart';
import '../../services/database.dart';
import '../../utils/theme/theme_provider.dart';
import '../../utils/user/user_provider.dart';
import '../../widgets/bookmark_list.dart';
import '../../widgets/search_box.dart';
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

  void _updateSearchTerm(String value) {
    setState(() {
      _searchTerm = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = getUser(context);

    final Stream<List<Newsletter>?> bookmarksStream =
        DatabaseService().getUserBookmarks(user?.uid);

    return Theme(
      data: getTheme(context),
      child: ScaffoldWrapper(
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
            BookmarkList(
              searchTerm: _searchTerm,
              bookmarks: bookmarksStream,
            ),
          ],
        )),
      ),
    );
  }
}
