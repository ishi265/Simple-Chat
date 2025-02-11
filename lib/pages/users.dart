import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/firestore/firestore.dart';

class Users extends StatelessWidget {
  Users({super.key});

  final FirestoreService getMyUsers = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: getMyUsers.getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List usersList = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: usersList.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = usersList[index];

                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;

                    String userHere = data['username'];
                    return ListTile(
                      title: Text(userHere),
                    );
                  });
            }
            return const Text('No data available');
          }),
    );
  }
}
