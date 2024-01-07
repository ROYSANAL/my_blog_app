part of 'create_blog_bloc.dart';

typedef Json = Map<String, dynamic>;

@immutable
abstract class CreateBlogEvent {}

class ImageButtonClicked extends CreateBlogEvent {}

class PostButtonClicked extends CreateBlogEvent {
  final CreateBlogForm form;

  PostButtonClicked(this.form);
}

class EditButtonClicked extends CreateBlogEvent {
  final Json data;
  final String id;
  final XFile? image;

  EditButtonClicked({required this.data, required this.id, this.image});
}
