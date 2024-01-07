import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_blog_app/core/widgets/simple_loader_dialog.dart';
import 'package:my_blog_app/core/widgets/simple_snack_bar.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/domain/remote/models/blogs/create_blog_form.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/create_blog/create_blog_bloc.dart';
import 'package:my_blog_app/presentation/features/blog/widget/image_selector.dart';

class CreateBlogPage extends StatefulWidget {
  final UserModel user;

  const CreateBlogPage({super.key, required this.user});

  @override
  State<CreateBlogPage> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends State<CreateBlogPage> {
  late TextEditingController title;
  late TextEditingController body;
  late XFile? image;

  @override
  void initState() {
    super.initState();
    image = null;
    title = TextEditingController();
    body = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocConsumer<CreateBlogBloc, CreateBlogState>(
        listener: (context, state) {
          if (state is BlogPosting) {
            SimpleLoaderDialog.show(context, "Posting Blog");
          }
          if (state is BlogPostedSuccessfully) {
            Navigator.of(context).pop();                                                                            // remove the dialog
            SimpleSnackBar.show(context, "blog posted");
          }
          if (state is BlogPostError) {
            Navigator.of(context).pop();                                                                                  // remove the dialog
            SimpleSnackBar.show(context, state.error);
          }
          if (state is BlogFormInvalid) {
            SimpleSnackBar.show(context, state.error);
          }
        },
        builder: (context, state) {
          return MaterialButton(
            onPressed: (state is BlogPosting)                                                            // disable when posting
                ? null
                : () {
                    final form = CreateBlogForm(
                      title: title.value.text.trim(),
                      body: body.value.text.trim(),
                      image: image,
                      authorId: widget.user.uid,
                      authorName: widget.user.name,
                    );
                    context.read<CreateBlogBloc>().add(PostButtonClicked(form));                               // trigger post event
                  },
            disabledColor: Colors.grey,
            color: Colors.deepOrange,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: const Text(
              "Post",
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
                  "Create a\nBlog",
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
                  url: null,
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
