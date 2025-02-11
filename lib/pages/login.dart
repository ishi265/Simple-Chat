import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/helper/message.dart';
import 'package:socialmedia/widgets/myButton.dart';
import 'package:socialmedia/widgets/textBox.dart';

class Login extends StatefulWidget {
  Function()? onTap;

  Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  login() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Navigator.pop(context);
      message('Please fill all fields', context);
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        message(e.code, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon of the page
              const Icon(
                Icons.person,
                size: 80,
              ),

              const Text(
                'M I N I M A L',
                style: TextStyle(fontSize: 28),
              ),

              const SizedBox(
                height: 30,
              ),

              // Textfeilds
              TextBoxItem(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController),
              const SizedBox(
                height: 10,
              ),
              TextBoxItem(
                  hintText: 'Email',
                  obscureText: true,
                  controller: passwordController),

              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot password?'),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 14,
              ),

              // button
              MyButton(myText: 'L O G I N', onTap: login),

              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Dont have an account?'),
                  GestureDetector(
                      onTap: widget.onTap, child: const Text('Register here')),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // other options
            ],
          ),
        ),
      ),
    );
  }
}
