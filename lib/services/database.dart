import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../models/newsletter.dart';
import '../models/article.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference _newslettersCollectionReference =
      FirebaseFirestore.instance.collection('newsletters');

  final CollectionReference _articlesCollectionReference =
      FirebaseFirestore.instance.collection('articles');

  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');

// store newsletters
  void storeNewsletters(List<Newsletter> newsletters) {
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

// get newsletters
  Stream<List<Newsletter>?> get newsletters {
    List<Newsletter> newsletterFromSnapshot(QuerySnapshot snapshot) {
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

    return _newslettersCollectionReference
        .snapshots()
        .map(newsletterFromSnapshot);
  }

  // store articles
  void storeArticles(List<Article> articles) async {
    for (var article in articles) {
      await _articlesCollectionReference.add({
        'title': article.title,
        'description': article.description,
        'imageUrl': article.imageUrl,
      });
    }
  }

  // get articles
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

// user
  Future<DocumentSnapshot> get userData {
    return _userCollectionReference.doc(uid).get();
  }

  Future updateUserInfo({
    String? username,
    String? email,
    String? phone,
    String? photo,
  }) async {
    return await _userCollectionReference.doc(uid).set({
      "username": username,
      "email": email,
      "phone": phone,
      "photo": photo,
    });
  }
}
