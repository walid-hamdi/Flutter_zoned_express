import 'package:flutter/material.dart';

import '../../widgets/custom_container.dart';
import '../../widgets/scaffold_wrapper.dart';
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
        child: ListView(
          children: const [
            Navbar(),
            SizedBox(height: 20),
            SearchBox(),
            Label(
              label: 'Newsletter',
            ),

            NewsletterList(),

            // Label(
            //   label: 'Article',
            // ),
            // ArticleList(),
            // NewsletterList(),
          ],
        ),
      ),
    );
  }
}
