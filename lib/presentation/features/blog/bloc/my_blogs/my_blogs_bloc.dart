import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/data/remote/entity/blog_entity.dart';
import 'package:my_blog_app/domain/remote/models/blogs/blog_model.dart';
import 'package:my_blog_app/domain/remote/repository/blog_repository_implementation.dart';
import 'package:my_blog_app/domain/remote/usecases/blogs/get_all_user_blogs_usecase.dart';

part 'my_blogs_event.dart';

part 'my_blogs_state.dart';

class MyBlogsBloc extends Bloc<MyBlogsEvent, MyBlogsState> {
  final _getAllBlogsUseCase =
      GetAllUserBlogsUseCase(BlogRepositoryImplementation());

  final String uid;

  StreamSubscription? sub;

  MyBlogsBloc(this.uid) : super(MyBlogsInitial()) {
    final res = _getAllBlogsUseCase.call(uid);
    if (res is Success<Stream<QuerySnapshot<BlogEntity>>>) {
      sub = res.data.listen((event) {
        add(DataChanged(event.docs));
      });
    } else {
      add(LoadingError(res.error!));
    }

    on<DataChanged>(_handleDataChanged);

    on<LoadingError>(
      (event, emit) => emit(BlogLoadingError(event.error)),
    );

    on<ReloadBlogs>(_handleReloadBlogs);
  }

  @override
  Future<Function> close() async {
    sub?.cancel();
    return super.close;
  }

  FutureOr<void> _handleDataChanged(
      DataChanged event, Emitter<MyBlogsState> emit) {
    emit(BlogsLoaded(
        event.snapshot.map((e) => BlogModel.fromEntity(e.data())).toList()));
  }

  FutureOr<void> _handleReloadBlogs(
      ReloadBlogs event, Emitter<MyBlogsState> emit) {}
}
