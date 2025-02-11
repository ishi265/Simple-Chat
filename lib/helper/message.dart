import 'package:flutter/material.dart';

void message(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              message,
              style: const TextStyle(fontSize: 16),
            ),
          ));
}
