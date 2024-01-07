part of 'edit_blog_bloc.dart';


@immutable
abstract class EditBlogEvent {}

class EditButtonClicked extends EditBlogEvent {
  final String changedTitle;
  final String changedBody;
  final BlogModel oldBlog;
  final XFile? image;
  final String id;

  EditButtonClicked(
      {required this.changedTitle,
      required this.changedBody,
      required this.oldBlog,
      required this.image,
      required this.id});
}
