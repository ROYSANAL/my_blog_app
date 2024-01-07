import 'package:flutter/material.dart';


// text field with show password button

class ShowPasswordTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;

  const ShowPasswordTextField(
      {super.key, required this.hint, required this.controller});

  @override
  State<ShowPasswordTextField> createState() => _ShowPasswordTextFieldState();
}

class _ShowPasswordTextFieldState extends State<ShowPasswordTextField> {
  late bool showPassword;

  @override
  void initState() {
    showPassword = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: showPassword, // show password
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline),
          hintText: widget.hint,
          suffix: IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: showPassword
                ? const Icon(Icons.visibility_outlined)
                : const Icon(Icons.visibility_off_outlined),
          ),
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
