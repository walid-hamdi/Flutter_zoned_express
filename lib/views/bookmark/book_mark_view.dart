import 'package:flutter/material.dart';

import '../../widgets/scaffold_wrapper.dart';

class BookmarkView extends StatelessWidget {
  const BookmarkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWrapper(
        child: Center(
      child: Text('Bookmark View'),
    ));
  }
}
