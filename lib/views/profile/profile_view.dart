import 'package:flutter/material.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/scaffold_wrapper.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: CustomAppBar(
        context: context,
        title: "Profile",
        widget: PopupMenuButton(
          itemBuilder: (context) => const [
            PopupMenuItem(
              child: Text("Option 1"),
            ),
            PopupMenuItem(
              child: Text("Option 2"),
            ),
            PopupMenuItem(
              child: Text("Option 3"),
            ),
          ],
          icon: const Icon(Icons.more_vert),
        ),
      ),
      child: CustomContainer(
        child: ListView(
          children: [],
        ),
      ),
    );
  }
}
