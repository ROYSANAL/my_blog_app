import 'package:flutter/material.dart';
import 'package:my_blog_app/core/widgets/responsive.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/presentation/main/main_screen_landscape.dart';
import 'package:my_blog_app/presentation/main/main_screen_portrait.dart';

class MainScreen extends StatefulWidget {
  final UserModel user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Responsive(
      portrait: MainScreenPortrait(user: widget.user,),                      // for portrait
      landscape: MainScreenLandScape(user : widget.user),                    // for landscape
    );
  }

}
