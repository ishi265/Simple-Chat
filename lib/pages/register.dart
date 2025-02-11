import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/helper/message.dart';
import 'package:socialmedia/widgets/myButton.dart';
import 'package:socialmedia/widgets/textBox.dart';

class Register extends StatefulWidget {
  Function()? onTap;

  Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void register() async {
    //show a loading dialog
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      message('Passwords dont match', context);
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        createUserDocument(userCredential);
        Navigator.pop(context);
        

      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        message(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': username.text,
      });
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
                  hintText: 'username',
                  obscureText: false,
                  controller: username),
              const SizedBox(
                height: 10,
              ),
              TextBoxItem(
                  hintText: 'Email',
                  obscureText: false,
                  controller: emailController),
              const SizedBox(
                height: 10,
              ),
              TextBoxItem(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController),

              const SizedBox(
                height: 10,
              ),
              TextBoxItem(
                  hintText: 'Confirm Password',
                  obscureText: true,
                  controller: confirmPasswordController),

              const SizedBox(
                height: 14,
              ),

              // button
              MyButton(myText: 'R E G I S T E R', onTap: register),

              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Dont have an account?'),
                  GestureDetector(
                      onTap: widget.onTap, child: const Text('Login')),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
