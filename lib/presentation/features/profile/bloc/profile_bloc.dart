import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/data/remote/entity/user_entity.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/domain/remote/repository/user_repository_implementation.dart';
import 'package:my_blog_app/domain/remote/usecases/user/get_user_data_usecase.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _getUserDataUseCase =
      GetUserDataUseCase(UserRepositoryImplementation());
  final String uid;

  StreamSubscription? _sub;

  @override
  Future<Function> close() async {
    _sub?.cancel();
    return () async {
      await super.close();
    };
  }

  ProfileBloc(this.uid) : super(ProfileInitial()) {
    final res = _getUserDataUseCase(uid);
    if (res is Success<Stream<DocumentSnapshot<UserEntity>>>) {
      _sub = res.data.listen((event) {
        if (event.exists && event.data() != null) {
          add(UserDataChanged(UserModel.fromUserEntity(event.data()!)));
        } else {
          add(UserDataError(res.error.toString()));
        }
      });
    }
    on<UserDataChanged>(_handleDataChange);
    on<UserDataError>(_handleDataError);
  }

  FutureOr<void> _handleDataChange(
      UserDataChanged event, Emitter<ProfileState> emit) {
    emit(DataAvailable(event.user));
  }

  FutureOr<void> _handleDataError(
      UserDataError event, Emitter<ProfileState> emit) {
    emit(UserError(event.error));
  }
}
