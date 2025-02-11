import 'package:flutter/material.dart';
import 'package:socialmedia/pages/login.dart';
import 'package:socialmedia/pages/register.dart';

// ignore: camel_case_types
class Login_or_register extends StatefulWidget {
  const Login_or_register({super.key});

  @override
  State<Login_or_register> createState() => _Login_or_registerState();
}

// ignore: camel_case_types
class _Login_or_registerState extends State<Login_or_register> {
  bool showLogin = true;

  void togglePages() {
    if (showLogin) {
      setState(() {
        showLogin = !showLogin;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return Login(onTap: togglePages);
    } else {
      return Register(onTap: togglePages);
    }
  }
}
