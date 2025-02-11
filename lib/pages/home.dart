import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/firestore/makingPost.dart';
import 'package:socialmedia/widgets/my_drawer.dart';
import 'package:socialmedia/widgets/textBox.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  final TextEditingController post = TextEditingController();
  final FirebaseDatabase postingPosts = FirebaseDatabase();

  

  void makePost() {
    if (post.text.isNotEmpty) {
      String message = post.text;

      postingPosts.addPost(message);
      post.clear(); // Clear only after successful post
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // Input field for posts
          TextBoxItem(
            hintText: 'Make a post',
            obscureText: false,
            controller: post,
          ),
          // Button to make a post
          GestureDetector(
            onTap: makePost,
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                "Post",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Display posts
          Expanded(
            child: StreamBuilder(
              stream: postingPosts.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No posts yet'),
                  );
                }

                final getPos = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: getPos.length,
                  itemBuilder: (context, index) {
                    final singlePost = getPos[index];

                    String message = singlePost['PostMessage'];
                    String userEmail = singlePost['UserEmail'];

                    return ListTile(
                      title: Text(message),
                      subtitle: Text(userEmail),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
