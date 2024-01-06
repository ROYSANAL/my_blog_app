part of 'my_blogs_bloc.dart';

@immutable
abstract class MyBlogsState {}

class MyBlogsInitial extends MyBlogsState {}

class BlogsLoading extends MyBlogsState {}

class BlogsLoaded extends MyBlogsState {
  final List<BlogModel> blogList;

  BlogsLoaded(this.blogList);
}

class BlogLoadingError extends MyBlogsState {
  final String error;

  BlogLoadingError(this.error);
}
