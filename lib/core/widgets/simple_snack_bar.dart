import 'package:flutter/material.dart';

// convenient snack bar - asks only for message

class SimpleSnackBar {
  static show(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
