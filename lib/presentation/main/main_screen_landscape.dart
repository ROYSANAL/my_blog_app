import 'package:flutter/material.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/presentation/features/blog/pages/blog_page.dart';
import 'package:my_blog_app/presentation/features/blog/pages/create_blog_page.dart';
import 'package:my_blog_app/presentation/features/profile/page/profile_page.dart';

class MainScreenLandScape extends StatefulWidget {
  final UserModel user;

  const MainScreenLandScape({super.key, required this.user});

  @override
  State<MainScreenLandScape> createState() => _MainScreenLandScapeState();
}

class _MainScreenLandScapeState extends State<MainScreenLandScape> {
  late int page;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    page = 0;
    pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(                                                                     // using navigation rail for landscape
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.messenger_outline), label: Text("blogs")),
                NavigationRailDestination(
                    icon: Icon(Icons.edit_outlined), label: Text("create")),
                NavigationRailDestination(
                    icon: Icon(Icons.person_outline_outlined),
                    label: Text("profile")),
              ],
              selectedIndex: page,
              onDestinationSelected: (value) {
                pageController.animateToPage(value,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
                setState(() {
                  page = value;
                });
              },
            ),
            Expanded(
                child: PageView.builder(
              itemCount: 3,
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),                                      // non scrollable page view
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return BlogPage(user: widget.user);
                  case 1:
                    return CreateBlogPage(user: widget.user);
                  case 2:
                    return ProfilePage(user: widget.user);
                  default:
                    return ProfilePage(user: widget.user);
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
