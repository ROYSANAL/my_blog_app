part of 'my_blogs_bloc.dart';

@immutable
abstract class MyBlogsEvent {}

class ReloadBlogs extends MyBlogsEvent {
  final String uid;

  ReloadBlogs(this.uid);
}

class DataChanged extends MyBlogsEvent {
  final List<QueryDocumentSnapshot<BlogEntity>> snapshot;

  DataChanged(this.snapshot);
}

class LoadingError extends MyBlogsEvent{
  final String error;

  LoadingError(this.error);
}
