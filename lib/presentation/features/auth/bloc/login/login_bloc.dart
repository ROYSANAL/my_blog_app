import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_blog_app/core/class/resource.dart';
import 'package:my_blog_app/domain/remote/models/auth/login_form.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/domain/remote/repository/user_repository_implementation.dart';
import 'package:my_blog_app/domain/remote/usecases/auth/login_user_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _loginUseCase = LoginUserUseCase(UserRepositoryImplementation());

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClicked>(_handleLoginButtonClicked);
  }

  FutureOr<void> _handleLoginButtonClicked(
      LoginButtonClicked event, Emitter<LoginState> emit) async {
    if (event.form.email.isEmpty) {
      emit(LoginFormError("Email is invalid"));
      return;
    }
    if (event.form.password.isEmpty) {
      emit(LoginFormError("Password is invalid"));
      return;
    }
    emit(LoginLoading());
    final res = await _loginUseCase.call(event.form);
    if (res is Success<UserModel>) {
      emit(LoggedInSuccessfully(res.data));
    } else {
      emit(LoginError(res.error!));
    }
  }
}
