part of 'create_blog_bloc.dart';

@immutable
abstract class CreateBlogState {}

class CreateBlogInitial extends CreateBlogState {}

class BlogFormInvalid extends CreateBlogState {
  final String error;

  BlogFormInvalid(this.error);
}

class ImageSelected extends CreateBlogState {
  final XFile image;

  ImageSelected(this.image);
}

class ImaheNotSelected extends CreateBlogState {}

class BlogPosting extends CreateBlogState {}

class BlogPostedSuccessfully extends CreateBlogState {
  final BlogModel blog;

  BlogPostedSuccessfully(this.blog);
}

class BlogPostError extends CreateBlogState {
  final String error;

  BlogPostError(this.error);
}

class BlogUpdating extends CreateBlogEvent {}
