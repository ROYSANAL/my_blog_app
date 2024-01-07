import 'package:flutter/material.dart';

class SimpleLoaderDialog {
  static show(BuildContext context, String title) {
    final dialog = AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title ,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
      surfaceTintColor: Colors.white,
      content: const Row(
        children: [
          Spacer(),
          CircularProgressIndicator(),
          Spacer(),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 40 ,vertical: 40),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => dialog,
    );
  }
}
