import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/newsletter.dart';

Stream<List<Newsletter>?> getNewsletters() {
  final CollectionReference newslettersStream =
      FirebaseFirestore.instance.collection('newsletters');

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

  return newslettersStream.snapshots().map(newsletterFromSnapshot);
}
