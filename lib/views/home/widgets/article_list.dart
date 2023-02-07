import 'package:flutter/material.dart';

import '../../../models/newsletter.dart';
// import 'list_builder.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({
    Key? key,
    required String? searchTerm,
    required List<Newsletter> newsletters,
  })  : _searchTerm = searchTerm,
        _newsletters = newsletters,
        super(key: key);

  final String? _searchTerm;
  final List<Newsletter> _newsletters;

  @override
  Widget build(BuildContext context) {
    // return ListBuilder(
    //   vertical: true,
    //   newsletters: _searchTerm == null
    //       ? _newsletters
    //       : _newsletters
    //           .where(
    //             (newsletter) =>
    //                 newsletter.title.toLowerCase().contains(_searchTerm ?? ""),
    //           )
    //           .toList(),
    // );
    return const Text("");
  }
}
