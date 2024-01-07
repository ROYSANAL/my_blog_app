import 'package:flutter/material.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/presentation/features/blog/pages/blog_page.dart';
import 'package:my_blog_app/presentation/features/blog/pages/create_blog_page.dart';
import 'package:my_blog_app/presentation/features/profile/page/profile_page.dart';

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
        bottomNavigationBar: Material(
          elevation: 1,
          child: Container(
            color: Colors.grey.withOpacity(0.05),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w500),
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.messenger_outline),
                      label: "blogs",
                      activeIcon: Icon(Icons.messenger)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.edit_outlined),
                      label: "create",
                      activeIcon: Icon(Icons.edit)),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_outlined),
                      label: "Profile",
                      activeIcon: Icon(Icons.person)),
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
            ),
          ),
        ),
        body: SafeArea(
          child: PageView.builder(
            itemBuilder: (context, index) {
              if(index==0) return BlogPage(user: widget.user);
              if(index==1) return CreateBlogPage(user: widget.user);
              if(index==2) return ProfilePage(user: widget.user);
            },
            controller: pageController,
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ));
  }
}
