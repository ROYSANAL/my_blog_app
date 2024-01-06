import 'package:flutter/material.dart';

class SimpleSnackBar {
  static show(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
