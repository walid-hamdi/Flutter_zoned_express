import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/newsletter.dart';
import '../../services/firebase/database.dart';
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
  final DatabaseService _db = DatabaseService();

  void _updateSearchTerm(String value) {
    setState(() {
      _searchTerm = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = getUser(context);

    final Stream<List<Newsletter>?> bookmarksStream =
        _db.getUserBookmarks(user?.uid);

    return Theme(
      data: getTheme(context),
      child: ScaffoldWrapper(
        appBar: CustomAppBar(
          context: context,
          title: "Bookmarks",
          widget: Row(
            children: [
              StreamBuilder<List<Newsletter>?>(
                stream: bookmarksStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    return InkWell(
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              'Are you sure you want to delete all your bookmarks?',
                            ),
                            actions: [
                              ElevatedButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  debugPrint("Cancel");
                                },
                              ),
                              ElevatedButton(
                                child: const Text('Delete'),
                                onPressed: () async {
                                  _db
                                      .unsetAllUserBookmarks(user?.uid)
                                      .whenComplete(() {
                                    Navigator.of(context).pop();
                                    debugPrint("delete");
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
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
