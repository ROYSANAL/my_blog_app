import 'package:flutter/cupertino.dart';

class Option{
  final IconData icon;
  final String text;
  final void Function() onTap;

  Option(this.onTap, {required this.icon, required this.text});
}