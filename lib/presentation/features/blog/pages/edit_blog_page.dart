import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';
import 'package:my_blog_app/domain/remote/models/blogs/create_blog_form.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/create_blog/create_blog_bloc.dart';
import 'package:my_blog_app/presentation/features/blog/widget/image_selector.dart';

class EditBlogPage extends StatefulWidget {
  final UserModel user;
  final BlogModel blog;

  const EditBlogPage({super.key, required this.user, required this.blog});

  @override
  State<EditBlogPage> createState() => _EditBlogPageState();
}

class _EditBlogPageState extends State<EditBlogPage> {
  late TextEditingController title;
  late TextEditingController body;
  late XFile? image;

  @override
  void initState() {
    super.initState();
    image = null;
    title = TextEditingController(text: widget.blog.title);

    body = TextEditingController(text: widget.blog.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocConsumer<CreateBlogBloc, CreateBlogState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialButton(
            onPressed: (state is BlogPosting)
                ? null
                : () {
                    final form = CreateBlogForm(
                      title: title.value.text.trim(),
                      body: body.value.text.trim(),
                      image: image,
                      authorId: widget.user.uid,
                      authorName: widget.user.name,
                    );
                    context.read<CreateBlogBloc>().add(PostButtonClicked(form));
                  },
            disabledColor: Colors.grey,
            color: Colors.deepOrange,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Edit Blog",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Write an interesting title",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: title,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Title"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ImageSelector(
                  url: widget.blog == null ? null : widget.blog!.imageUrl,
                  onImageSelected: (p0) {
                    image = p0;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text("Tell your story"),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: body,
                    maxLines: 10,
                    maxLength: 500,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Body")),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
