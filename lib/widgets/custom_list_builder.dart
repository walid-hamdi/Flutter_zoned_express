import 'package:flutter/material.dart';

class CustomListBuilder<T> extends StatelessWidget {
  final List<T> items;
  final Function itemBuilder;

  const CustomListBuilder({
    Key? key,
    required this.items,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index]);
      },
    );
  }
}
