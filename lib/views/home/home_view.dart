import 'package:flutter/material.dart';

import '../../widgets/scaffold_wrapper.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
        child: Container(
      color: Colors.amber,
      child: const Center(
        child: Text(
          'Home View',
        ),
      ),
    ));
  }
}
