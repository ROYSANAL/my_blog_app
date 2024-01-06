import 'package:flutter/material.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/presentation/features/blog/pages/blog_page.dart';
import 'package:my_blog_app/presentation/features/blog/pages/create_blog_page.dart';

class MainScreenPortrait extends StatefulWidget {
  final UserModel user;

  const MainScreenPortrait({super.key, required this.user});

  @override
  State<MainScreenPortrait> createState() => _MainScreenPortraitState();
}

class _MainScreenPortraitState extends State<MainScreenPortrait> {
  late PageController pageController;
  late int page;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    page = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "home"),
          ],
          selectedItemColor: Colors.deepOrange,
          onTap: (e) {
            setState(() {
              page = e;
            });
            pageController.animateToPage(e,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
          },
          currentIndex: page,
        ),
        body: SafeArea(
          child: PageView.builder(
            itemBuilder: (context, index) {
              if (index == 0) return const BlogPage();
              if (index == 1) {
                return CreateBlogPage(
                  user: widget.user,
                );
              }
            },
            controller: pageController,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ));
  }
}
