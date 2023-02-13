import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../../utils/error_util.dart';
import "./database.dart";
import 'firebase_exception_handler.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final DatabaseService _db = DatabaseService();

  Future uploadUserPhoto(
    context,
    File? file,
    SettableMetadata? metadata,
    String? userId,
  ) async {
    try {
      await _firebaseStorage
          .ref()
          .child('users/$userId/photo.jpg')
          .putFile(
            file!,
            metadata,
          )
          .then(
        (result) {
          if (result.state == TaskState.success) {
            Future<String> downloadUrl = result.ref.getDownloadURL();
            _db.setUserPhoto(
              userId: userId,
              downloadUrl: downloadUrl,
            );
          }
        },
      );
    } catch (e) {
      String errorMessage = FirebaseExceptionHandler.handleException(e);
      ErrorUtil.showErrorDialog(context, errorMessage);
    }
  }
}
