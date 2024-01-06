import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';

class BlogListItem extends StatelessWidget {
  final BlogModel blog;

  const BlogListItem(this.blog, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.network(
              blog.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(fontWeight: FontWeight.bold ,fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8,),
                Text(
                  "by ${blog.authorName} on ${blog.publishDate.toFormattedString()}",
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension on DateTime {
  String toFormattedString() {
    final formatter = DateFormat("dd MMM , yyyy");
    return formatter.format(this);
  }
}
