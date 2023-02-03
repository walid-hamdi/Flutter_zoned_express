import 'package:flutter/material.dart';

import '../../widgets/scaffold_wrapper.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWrapper(
        child: Center(
      child: Text('Profile View'),
    ));
  }
}
