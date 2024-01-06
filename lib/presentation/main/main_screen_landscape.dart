import 'package:flutter/material.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';

class MainScreenLandScape extends StatefulWidget {
  final UserModel user;
  const MainScreenLandScape({super.key, required this.user});

  @override
  State<MainScreenLandScape> createState() => _MainScreenLandScapeState();
}

class _MainScreenLandScapeState extends State<MainScreenLandScape> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
