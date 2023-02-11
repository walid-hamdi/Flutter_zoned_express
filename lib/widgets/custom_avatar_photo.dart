import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/storage.dart';
import '../utils/user/user_provider.dart';
import './cached_image.dart';
import '../../../utils/constants.dart';

class CustomAvatarPhoto extends StatelessWidget {
  CustomAvatarPhoto({
    Key? key,
    required this.data,
    this.mutable = false,
  }) : super(key: key);

  final bool mutable;

  final Map<String, dynamic> data;
  final StorageService _storage = StorageService();

  @override
  Widget build(BuildContext context) {
    final User? user = getUser(context);

    return Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
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
          mutable
              ? Positioned(
                  right: -10,
                  bottom: -10,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    // padding: const EdgeInsets.all(2),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_a_photo,
                        // color: Colors.blue[700],
                        size: 30,
                      ),
                      onPressed: () async {
                        debugPrint("uploading...");
                        await _storage.uploadImage(
                          context,
                          user?.uid,
                          defaultProfilePlaceholderPhoto,
                        );
                      },
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
