import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';
import 'package:my_blog_app/domain/remote/usecases/blogs/update_blog_usecase.dart';
import 'package:my_blog_app/domain/remote/usecases/blogs/update_blog_with_image_usecase.dart';

part 'edit_blog_event.dart';

part 'edit_blog_state.dart';

typedef Json = Map<String, dynamic>;

class EditBlogBloc extends Bloc<EditBlogEvent, EditBlogState> {
  final _updateBlogUseCase = UpdateBlogUseCase();
  final _updateBlogWithImageUseCase = UpdateBlogWithImageUseCase();

  EditBlogBloc() : super(EditBlogInitial()) {
    on<EditButtonClicked>(_handleEdit);
  }

  FutureOr<void> _handleEdit(
      EditButtonClicked event, Emitter<EditBlogState> emit) async {
    if (event.changedTitle == event.oldBlog.title &&
        event.changedBody == event.oldBlog.body) {
      emit(EditBlogFormInvalid("Blog Unchanged"));
      return;
    }
    if (event.changedTitle.isEmpty) {
      emit(EditBlogFormInvalid("Title Invalid"));
      return;
    }
    if (event.changedBody.isEmpty) {
      emit(EditBlogFormInvalid("Body Invalid"));
      return;
    }
    emit(EditingBlog());
    var data = <String, dynamic>{};
    if (event.changedTitle != event.oldBlog.title) {
      data = {...data, "title": event.changedTitle};
    }
    if (event.changedBody != event.oldBlog.body) {
      data = {...data, "body": event.changedBody};
    }
    final res = event.image != null
        ? await _updateBlogWithImageUseCase.call(data, event.image!, event.id)
        : await _updateBlogUseCase(data, event.id);

    if (res is Success<Json>) {
      emit(BlogEditedSuccessfully(res.data));
    } else {
      emit(BlogEditFailed(res.error.toString()));
    }
  }
}
