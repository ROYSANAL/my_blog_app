import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';
import 'package:my_blog_app/domain/remote/models/blogs/create_blog_form.dart';
import 'package:my_blog_app/domain/remote/repository/blog_repository_implementation.dart';
import 'package:my_blog_app/domain/remote/usecases/blogs/create_blog_usecase.dart';
import 'package:my_blog_app/domain/remote/usecases/blogs/pick_image_usecase.dart';
import 'package:uuid/uuid.dart';

part 'create_blog_event.dart';

part 'create_blog_state.dart';

class CreateBlogBloc extends Bloc<CreateBlogEvent, CreateBlogState> {
  final _createBlogUseCase = CreateBlogUseCase(BlogRepositoryImplementation());
  final _pickImageUseCase = PickImageUseCase();

  CreateBlogBloc() : super(CreateBlogInitial()) {
    on<ImageButtonClicked>(_handleImageSelection);

    on<PostButtonClicked>(_handlePosting);
  }

  FutureOr<void> _handleImageSelection(
      ImageButtonClicked event, Emitter<CreateBlogState> emit) async {
    final res = await _pickImageUseCase();
    if (res is Success<XFile>) {
      emit(ImageSelected(res.data));
    } else {
      emit(ImaheNotSelected());
    }
  }

  FutureOr<void> _handlePosting(
      PostButtonClicked event, Emitter<CreateBlogState> emit) async {
    final id = const Uuid().v1();
    if (event.form.title.isEmpty) {
      emit(BlogFormInvalid("title Invalid"));
      return;
    }
    if (event.form.body.isEmpty) {
      emit(BlogFormInvalid("body Invalid"));
      return;
    }
    if (event.form.authorId.isEmpty) {
      emit(BlogFormInvalid("author Invalid"));
      return;
    }
    if (event.form.authorName.isEmpty) {
      emit(BlogFormInvalid("author Invalid"));
      return;
    }
    if (event.form.image == null) {
      emit(BlogFormInvalid("image Invalid"));
      return;
    }
    emit(BlogPosting());
    final res = await _createBlogUseCase.call(event.form, id);
    if (res is Success<BlogModel>) {
      emit(BlogPostedSuccessfully(res.data));
    } else {
      emit(BolgPostError(res.error.toString()));
    }
  }
}
