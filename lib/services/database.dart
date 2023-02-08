import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/newsletter.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference _newslettersCollectionReference =
      FirebaseFirestore.instance.collection('newsletters');

  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');

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
