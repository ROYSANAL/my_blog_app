import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';

class BlogListItem extends StatelessWidget {
  final void Function(BlogModel) onTap;
  final BlogModel blog;

  const BlogListItem(this.blog, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        onTap: () {
          onTap(blog);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Hero(
                tag: "img+${blog.id}",
                child: Image.network(
                  blog.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.fill,
                ),
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "by ${blog.authorName} on ${blog.publishDate.toFormattedString()}",
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension CustomDate on DateTime {
  String toFormattedString() {
    final formatter = DateFormat("dd MMM , yyyy");
    return formatter.format(this);
  }
}
