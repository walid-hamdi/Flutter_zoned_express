import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  dismissKeyboard(context) {
    // Dismiss the keyboard when the Row is tapped
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            dismissKeyboard(context);
          },
          child: Row(
            children: const [
              Icon(Icons.dashboard_outlined),
              SizedBox(
                width: 5,
              ),
              Text("Home"),
            ],
          ),
        ),
        InkWell(
            onTap: () {
              dismissKeyboard(context);
            },
            child: const Icon(Icons.notifications_none)),
      ],
    );
  }
}
