import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  // read all users in the table

  Stream<QuerySnapshot> getUsers() {
    final usersStream = users.snapshots();

    return usersStream;
  }
}
