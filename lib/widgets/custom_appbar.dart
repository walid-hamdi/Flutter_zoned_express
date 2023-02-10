import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
      {Key? key,
      required context,
      required String title,
      required Widget widget})
      : super(
          key: key,
          title: Text(title),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HomeView(),
                //   ),
                //   (route) => false,
                // );
              }
            },
          ),
          actions: [
            widget,
          ],
        );
}
