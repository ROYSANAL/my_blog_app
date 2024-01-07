import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_blog_app/core/widgets/simple_loader_dialog.dart';
import 'package:my_blog_app/core/widgets/simple_snack_bar.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/edit_blog/edit_blog_bloc.dart';
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
    title = TextEditingController(text: widget.blog.title);                                         // already filled

    body = TextEditingController(text: widget.blog.body);                                           // already filled
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocConsumer<EditBlogBloc, EditBlogState>(
        listener: (context, state) {
          if (state is EditingBlog) {
            SimpleLoaderDialog.show(context, "Updating Blog");
          } else if (state is BlogEditedSuccessfully) {
            Navigator.of(context)
              ..pop()
              ..pop();                                                                                      // remove the dialog and read page
            SimpleSnackBar.show(context, "blog updated");
          } else if (state is BlogEditFailed) {
            Navigator.of(context).pop();                                                                            // remove dialog
            SimpleSnackBar.show(context, state.error);
          } else if (state is EditBlogFormInvalid) {
            SimpleSnackBar.show(context, state.error);
          }
        },
        builder: (context, state) {
          return MaterialButton(
            onPressed: (state is EditingBlog)                                                                    // disable when updating
                ? null
                : () {
                    context.read<EditBlogBloc>().add(EditButtonClicked(                                               // trigger edit
                          changedTitle: title.value.text.trim(),
                          changedBody: body.value.text.trim(),
                          oldBlog: widget.blog,
                          image: image,
                          id: widget.blog.id,
                        ));
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
                  url: widget.blog.imageUrl,
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
