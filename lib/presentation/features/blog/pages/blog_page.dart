import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/my_blogs/my_blogs_bloc.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/read_blog_bloc/read_blog_bloc.dart';
import 'package:my_blog_app/presentation/features/blog/pages/read_blog_page.dart';
import 'package:my_blog_app/presentation/features/blog/widget/blog_list_item.dart';

class BlogPage extends StatefulWidget {
  final UserModel user;
  const BlogPage({super.key, required this.user});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My Blogs",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Expanded(child: BlocBuilder<MyBlogsBloc, MyBlogsState>(
            builder: (context, state) {
              if (state is BlogsLoaded) {
                if (state.blogList.isEmpty) {
                  return const Center(
                    child: Text("no blogs"),
                  );
                }
                return ListView.builder(
                    itemCount: state.blogList.length,
                    itemBuilder: (context, index) {
                      final item = state.blogList[index];
                      return BlogListItem(
                        item,
                        onTap: (p0) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => BlocProvider<ReadBlogBloc>(
                                    create: (context) => ReadBlogBloc(),
                                    child: ReadBlogPage(blog: item ,user: widget.user,),
                                  )));
                        },
                      );
                    });
              } else if (state is BlogLoadingError) {
                return Text(state.error);
              } else {
                return const Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
