import 'package:flutter/material.dart';
import 'package:zoned_express/models/newsletter.dart';

import '../../services/database.dart';
import '../../widgets/newsletter_list.dart';
import '../../widgets/search_box.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_container.dart';
// import '../../widgets/newsletter_list.dart';
import '../../widgets/scaffold_wrapper.dart';

class BookmarkView extends StatefulWidget {
  const BookmarkView({Key? key}) : super(key: key);

  @override
  State<BookmarkView> createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
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
            vertical: true,
            fullHeight: true,
            newsletters: _newslettersStream,
          ),
        ],
      )),
    );
  }
}
