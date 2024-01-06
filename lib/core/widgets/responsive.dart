import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget portrait;
  final Widget landscape;

  const Responsive(
      {super.key, required this.portrait, required this.landscape});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 400) {
        return portrait;
      } else {
        return landscape;
      }
    });
  }
}
