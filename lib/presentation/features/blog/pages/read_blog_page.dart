import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_blog_app/core/widgets/simple_loader_dialog.dart';
import 'package:my_blog_app/core/widgets/simple_snack_bar.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';
import 'package:my_blog_app/domain/remote/models/blogs/option.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/edit_blog/edit_blog_bloc.dart';
import 'package:my_blog_app/presentation/features/blog/bloc/read_blog_bloc/read_blog_bloc.dart';
import 'package:my_blog_app/presentation/features/blog/pages/edit_blog_page.dart';
import 'package:my_blog_app/presentation/features/blog/widget/data_chip.dart';

class ReadBlogPage extends StatefulWidget {
  final BlogModel blog;
  final UserModel user;

  const ReadBlogPage({super.key, required this.blog, required this.user});

  @override
  State<ReadBlogPage> createState() => _ReadBlogPageState();
}

class _ReadBlogPageState extends State<ReadBlogPage> {
  late List<Option> options;                                                                     // list of option for pop-up menu

  @override
  void initState() {
    super.initState();
    options = [
      Option(icon: Icons.delete_outline, text: "delete", () {                                  // trigger delete on tap
        context.read<ReadBlogBloc>().add(DeleteBlogClicked(widget.blog));
      }),
      Option(icon: Icons.edit_outlined, text: "edit", () {                                     // trigger edit on tap
        context.read<ReadBlogBloc>().add(EditBlogClicked(widget.blog));
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return options
                  .map((e) => PopupMenuItem(
                        onTap: e.onTap,
                        child: Row(
                          children: [
                            Icon(e.icon),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(e.text),
                          ],
                        ),
                      ))
                  .toList();
            },
          )
        ],
      ),
      body: SafeArea(
        child: BlocListener<ReadBlogBloc, ReadBlogState>(
          listener: (context, state) {
            if (state is DeletingBlog) {
              SimpleLoaderDialog.show(context, "Deleting Blog");
            } else if (state is DeletedBlogSuccessfully) {
              Navigator.of(context)
                ..pop()
                ..pop();
              SimpleSnackBar.show(context, "blog deleted");
            } else if (state is DeleteBlogError) {
              Navigator.of(context).pop();
              SimpleSnackBar.show(context, state.error);
            } else if (state is GoToEditBlog) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => BlocProvider<EditBlogBloc>(
                        create: (context) => EditBlogBloc(),
                        child:
                            EditBlogPage(user: widget.user, blog: state.blog),                             // to edit page
                      )));
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.blog.title,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DataChip(
                          icon: Icons.history,
                          data: widget.blog.publishDate.toFormattedString(),
                        ),
                      ),
                      Expanded(
                        child: DataChip(
                          icon: Icons.person_outline_outlined,
                          data: widget.blog.authorName,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.2)),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        child: Hero(
                          tag: "img+${widget.blog.id}",
                          child: Image.network(
                            widget.blog.imageUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    widget.blog.body,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
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
