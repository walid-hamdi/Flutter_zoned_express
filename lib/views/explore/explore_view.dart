import 'package:flutter/material.dart';

import '../../widgets/scaffold_wrapper.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWrapper(
        child: Center(
      child: Text('Explore View'),
    ));
  }
}
