import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDatabase {
  // loading the curent user
  User? user = FirebaseAuth.instance.currentUser;

  // getting all users first
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
    });
  }

  // read the posts
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance.collection('Posts').orderBy('TimeStamp', descending: true).snapshots();
    return postsStream;
  }
}
