import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../../services/database.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final DatabaseService _db = DatabaseService();

  Future<void> uploadImage(
      BuildContext context, String? userId, String defaultPhoto) async {
    XFile? image;

    // Check Permissions
    await Permission.photos.request();
    await Permission.camera.request();
    // await Permission.storage.request();

    var permissionPhotoStatus = await Permission.photos.status;
    var permissionCameraStatus = await Permission.camera.status;
    var permissionStorageStatus = await Permission.storage.status;

    if (permissionPhotoStatus.isGranted &&
        permissionCameraStatus.isGranted &&
        permissionStorageStatus.isGranted) {
      // Show dialog to select source
      var source = await customChoosingDialog(context);
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
        await _firebaseStorage
            .ref()
            .child('users/$userId/photo.jpg')
            .putFile(
              file,
              metadata,
            )
            .then((result) {
          if (result.state == TaskState.success) {
            Future<String> downloadUrl = result.ref.getDownloadURL();
            _db.setUserPhoto(
              userId: userId,
              downloadUrl: downloadUrl,
            );
          }
        });
      } else {
        debugPrint('No Image Path Received');
      }
    } else {
      debugPrint('Permission not granted. Try Again with permission access');
    }
  }
}

Future<dynamic> customChoosingDialog(BuildContext context) async {
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
