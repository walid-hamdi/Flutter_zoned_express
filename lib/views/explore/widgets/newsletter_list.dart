import 'package:flutter/material.dart';
import 'package:zoned_express/models/newsletter.dart';
import 'package:zoned_express/widgets/list_builder.dart';

class NewsletterList extends StatelessWidget {
  const NewsletterList({
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
    return ListBuilder(
      newsletters: _searchTerm == null
          ? _newsletters
          : _newsletters
              .where(
                (newsletter) =>
                    newsletter.title.toLowerCase().contains(_searchTerm ?? ""),
              )
              .toList(),
    );
  }
}
