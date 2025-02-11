import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/auth/login_or_register.dart';
import 'package:socialmedia/pages/home.dart';

class AuthPae extends StatelessWidget {
  const AuthPae({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return const Login_or_register();
            }
          }),
    );
  }
}
