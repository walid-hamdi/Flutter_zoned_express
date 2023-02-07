import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/newsletter.dart';

void storeNewsletters(List<Newsletter> newsletters) {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('newsletters');

  for (var newsletter in newsletters) {
    collectionReference.add({
      'title': newsletter.title,
      'description': newsletter.description,
      'readTime': newsletter.readTime,
      'writer': newsletter.writer,
      'topic': newsletter.topic,
      'imageUrl': newsletter.imageUrl,
    });
  }
}
