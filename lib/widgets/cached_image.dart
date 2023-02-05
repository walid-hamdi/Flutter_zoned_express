import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final Widget Function(BuildContext context, ImageProvider imageProvider)
      imageBuilder;
  final Widget Function(BuildContext context, String url) placeholder;
  final Widget Function(BuildContext context, String url, dynamic error)
      errorWidget;

  const CachedNetworkImageWidget({
    Key? key,
    required this.imageUrl,
    required this.imageBuilder,
    required this.placeholder,
    required this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: imageBuilder,
      placeholder: placeholder,
      errorWidget: errorWidget,
    );
  }
}
