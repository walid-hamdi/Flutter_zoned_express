import 'package:flutter/material.dart';

import '../../../models/newsletter.dart';

class NewsletterDetailsView extends StatelessWidget {
  final Newsletter newsletter;

  const NewsletterDetailsView({
    Key? key,
    required this.newsletter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Center(
        child: Text(newsletter.title),
      ),
    );
  }
}
