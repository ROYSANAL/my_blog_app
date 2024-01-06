import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/my_blogs/my_blogs_bloc.dart';
import 'package:my_blog_app/presentation/features/blog/widget/blog_list_item.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

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
                      return BlogListItem(item);
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
