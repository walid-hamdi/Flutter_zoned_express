import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.dashboard_outlined),
            SizedBox(
              width: 5,
            ),
            Text("Home"),
          ],
        ),
        const Icon(Icons.notifications_none),
      ],
    );
  }
}
