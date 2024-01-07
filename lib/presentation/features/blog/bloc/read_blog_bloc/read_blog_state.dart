part of 'read_blog_bloc.dart';

@immutable
abstract class ReadBlogState {}

class ReadBlogInitial extends ReadBlogState {}

class DeletingBlog extends ReadBlogState {}

class DeleteBlogError extends ReadBlogState {
  final String error;

  DeleteBlogError(this.error);
}

class DeletedBlogSuccessfully extends ReadBlogState {}

class GoToEditBlog extends ReadBlogState{
  final BlogModel blog;

  GoToEditBlog(this.blog);
}
