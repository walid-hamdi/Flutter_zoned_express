import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../services/storage.dart';
import './cached_image.dart';
import '../../../utils/constants.dart';

class CustomAvatarPhoto extends StatelessWidget {
  CustomAvatarPhoto({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final StorageService _storage = StorageService();

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          CachedNetworkImageWidget(
            imageUrl: data["photo"] ?? defaultProfilePlaceholderPhoto,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 40,
              backgroundImage: imageProvider,
            ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const SizedBox(
              height: 90,
              child: Icon(Icons.error),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () async {
                await _storage.uploadImage(
                  context,
                  user?.uid,
                  defaultProfilePlaceholderPhoto,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
