import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/newsletter.dart';
import '../../models/article.dart';
import '../../utils/error_util.dart';
import 'firebase_exception_handler.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference _newslettersCollectionReference =
      FirebaseFirestore.instance.collection('newsletters');

  final CollectionReference _articlesCollectionReference =
      FirebaseFirestore.instance.collection('articles');

  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');

// ------------------------------------------newsletters
  void setNewsletters(List<Newsletter> newsletters) {
    for (var newsletter in newsletters) {
      _newslettersCollectionReference.add({
        'title': newsletter.title,
        'description': newsletter.description,
        'readTime': newsletter.readTime,
        'writer': newsletter.writer,
        'topic': newsletter.topic,
        'imageUrl': newsletter.imageUrl,
      });
    }
  }

  List<Newsletter> _newsletterFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(
          (doc) => Newsletter(
            title: doc['title'],
            description: doc['description'],
            readTime: doc['readTime'],
            writer: doc['writer'],
            topic: doc['topic'],
            imageUrl: doc['imageUrl'],
          ),
        )
        .toList();
  }

  Stream<List<Newsletter>?> get newsletters {
    return _newslettersCollectionReference
        .snapshots()
        .map(_newsletterFromSnapshot);
  }

  // -----------------------------------------articles
  void setArticles(List<Article> articles) async {
    for (var article in articles) {
      await _articlesCollectionReference.add({
        'title': article.title,
        'description': article.description,
        'imageUrl': article.imageUrl,
      });
    }
  }

  Stream<List<Article>?> get articles {
    List<Article> articleFromSnapshot(QuerySnapshot snapshot) {
      return snapshot.docs
          .map(
            (doc) => Article(
              title: doc['title'],
              description: doc['description'],
              imageUrl: doc['imageUrl'],
            ),
          )
          .toList();
    }

    return _articlesCollectionReference.snapshots().map(articleFromSnapshot);
  }

// ---------------------------------------------user bookmarks
  late String documentId;
  setUserBookmarks(String? userId, Newsletter newsletter) {
    documentId =
        _userCollectionReference.doc(userId).collection("bookmarks").doc().id;

    _userCollectionReference.doc(userId).collection("bookmarks").doc().set({
      "title": newsletter.title,
      "description": newsletter.description,
      "readTime": newsletter.readTime,
      "writer": newsletter.writer,
      "topic": newsletter.topic,
      "imageUrl": newsletter.imageUrl,
      "timestamp": Timestamp.now()
    });
  }

  unsetUserBookmark(String? userId) {
    _userCollectionReference
        .doc(userId)
        .collection("bookmarks")
        .doc(documentId)
        .delete();
  }

  Stream<List<Newsletter>?> getUserBookmarks(String? userId) {
    return _userCollectionReference
        .doc(userId)
        .collection("bookmarks")
        .snapshots()
        .map(_newsletterFromSnapshot);
  }

// -------------------------------------------user
  Future<DocumentSnapshot<Object?>> get userData {
    return _userCollectionReference.doc(uid).get();
  }

  Future updateUserInfo({
    required context,
    required String userId,
    required String username,
    required String email,
    required String phone,
    required String photo,
  }) async {
    try {
      return await _userCollectionReference.doc(userId).set({
        "username": username,
        "email": email,
        "phone": phone,
        "photo": photo,
      });
    } catch (e) {
      String errorMessage = FirebaseExceptionHandler.handleException(e);
      return ErrorUtil.showErrorDialog(context, errorMessage);
    }
  }

  Future setUserPhoto(
      {context, String? userId, Future<String>? downloadUrl}) async {
    try {
      return await _userCollectionReference
          .doc(userId)
          .update({'photo': downloadUrl});
    } catch (e) {
      String errorMessage = FirebaseExceptionHandler.handleException(e);
      ErrorUtil.showErrorDialog(context, errorMessage);
    }
  }

  Future deleteUser({required context, required String userId}) async {
    try {
      return await _userCollectionReference.doc(userId).delete();
    } catch (e) {
      String errorMessage = FirebaseExceptionHandler.handleException(e);
      ErrorUtil.showErrorDialog(context, errorMessage);
    }
  }
}
