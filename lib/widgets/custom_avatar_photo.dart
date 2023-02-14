import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import "package:permission_handler/permission_handler.dart";
import 'dart:io';

import '../utils/error_util.dart';
import '../utils/user/user_provider.dart';
import './cached_image.dart';
import '../../../utils/constants.dart';
import "../../../services/firebase/storage.dart";

class CustomAvatarPhoto extends StatefulWidget {
  const CustomAvatarPhoto({
    Key? key,
    required this.data,
    this.mutable = false,
  }) : super(key: key);

  final bool mutable;

  final Map<String, dynamic> data;

  @override
  State<CustomAvatarPhoto> createState() => _CustomAvatarPhotoState();
}

class _CustomAvatarPhotoState extends State<CustomAvatarPhoto> {
  final ImagePicker _imagePicker = ImagePicker();

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
            imageUrl: widget.data["photo"] ?? defaultProfilePlaceholderPhoto,
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
          widget.mutable
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
                        _uploadImage(
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

  Future<void> _uploadImage(
      BuildContext context, String? userId, String defaultPhoto) async {
    XFile? image;

    // Check Permissions
    await Permission.photos.request();
    await Permission.camera.request();
    await Permission.storage.request();

    var permissionPhotoStatus = await Permission.photos.status;
    var permissionCameraStatus = await Permission.camera.status;
    var permissionStorageStatus = await Permission.storage.status;

    if (permissionPhotoStatus.isGranted &&
        permissionCameraStatus.isGranted &&
        permissionStorageStatus.isGranted) {
      // Show dialog to select source
      if (!mounted) return;
      var source = await _sourceSelectedDialog(context);
      // Select Image
      image =
          await _imagePicker.pickImage(source: source ?? ImageSource.gallery);

      var file = File(
        image?.path ?? defaultPhoto,
      );

      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path},
      );

      if (image != null) {
        if (!mounted) return;
        _storage.uploadUserPhoto(context, file, metadata, userId);
      } else {
        String errorMessage = 'No Image Path Received';
        if (!mounted) return;
        ErrorUtil.showErrorDialog(context, errorMessage);
      }
    } else {
      String errorMessage =
          'Permission not granted. Try Again with permission access';
      if (!mounted) return;
      ErrorUtil.showErrorDialog(context, errorMessage);
    }
  }
}

// source selected dialog
Future<dynamic> _sourceSelectedDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: const Text("Select Source"),
      children: [
        SimpleDialogOption(
          child: const Text("Gallery"),
          onPressed: () => Navigator.pop(context, ImageSource.gallery),
        ),
        SimpleDialogOption(
          child: const Text("Camera"),
          onPressed: () => Navigator.pop(context, ImageSource.camera),
        ),
      ],
    ),
  );
}
