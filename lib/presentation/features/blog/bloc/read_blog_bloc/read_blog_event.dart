part of 'read_blog_bloc.dart';

@immutable
abstract class ReadBlogEvent {
  final BlogModel blog;

  const ReadBlogEvent(this.blog);
}

class EditBlogClicked extends ReadBlogEvent {
  const EditBlogClicked(super.blog);
}

class DeleteBlogClicked extends ReadBlogEvent {
  const DeleteBlogClicked(super.blog);
}
