part of 'edit_blog_bloc.dart';

@immutable
abstract class EditBlogState {}

class EditBlogInitial extends EditBlogState {}

class EditBlogFormInvalid extends EditBlogState{
  final String error;

  EditBlogFormInvalid(this.error);
}

class EditingBlog extends EditBlogState{}

class BlogEditedSuccessfully extends EditBlogState{
  final  Json data;

  BlogEditedSuccessfully(this.data);
}

class BlogEditFailed extends EditBlogState{
  final String error;

  BlogEditFailed(this.error);
}
