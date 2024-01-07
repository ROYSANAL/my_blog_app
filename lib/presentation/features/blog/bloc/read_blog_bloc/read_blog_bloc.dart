import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';
import 'package:my_blog_app/domain/remote/repository/blog_repository_implementation.dart';
import 'package:my_blog_app/domain/remote/usecases/blogs/delete_blog_usecase.dart';

part 'read_blog_event.dart';

part 'read_blog_state.dart';

class ReadBlogBloc extends Bloc<ReadBlogEvent, ReadBlogState> {
  final _deleteBlogUseCase = DeleteBlogUseCase(BlogRepositoryImplementation());

  ReadBlogBloc() : super(ReadBlogInitial()) {
    on<DeleteBlogClicked>(_handleDeleteBlog);

    on<EditBlogClicked>(_handleEditBlogClicked);
  }

  FutureOr<void> _handleDeleteBlog(
      DeleteBlogClicked event, Emitter<ReadBlogState> emit) async {
    emit(DeletingBlog());
    final res = await _deleteBlogUseCase(event.blog);
    if (res is Success<BlogModel>) {
      emit(DeletedBlogSuccessfully());
    } else {
      emit(DeleteBlogError(res.error.toString()));
    }
  }

  FutureOr<void> _handleEditBlogClicked(
      EditBlogClicked event, Emitter<ReadBlogState> emit) {
    emit(GoToEditBlog(event.blog));
  }
}
