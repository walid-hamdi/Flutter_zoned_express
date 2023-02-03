import 'package:flutter/material.dart';

import '../../widgets/custom_container.dart';
import '../../widgets/scaffold_wrapper.dart';
import 'widgets/article_list.dart';
import 'widgets/label.dart';
import 'widgets/navbar.dart';
import 'widgets/newsletter_list.dart';
import 'widgets/search_box.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      child: CustomContainer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Navbar(),
              SizedBox(height: 20),
              SearchBox(),
              SizedBox(height: 10),
              Label(
                label: 'Newsletter',
              ),
              NewsletterList(),
              Label(
                label: 'Article',
              ),
              SizedBox(height: 10),
              ArticleList(),
              NewsletterList(),
            ],
          ),
        ),
      ),
    );
  }
}
