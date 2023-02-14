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
          elevation: 1,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {}
            },
          ),
          actions: [
            widget,
          ],
        );
}
