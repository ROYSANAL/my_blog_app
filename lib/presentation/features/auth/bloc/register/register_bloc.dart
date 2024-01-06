import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_blog_app/domain/remote/models/auth/sign_up_form.dart';
import 'package:my_blog_app/domain/remote/models/auth/user_model.dart';
import 'package:my_blog_app/domain/remote/repository/user_repository_implementation.dart';
import 'package:my_blog_app/domain/remote/usecases/auth/register_user_usecase.dart';


import '../../../../../core/class/resource.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final _registerUseCase = RegisterUserUseCase(UserRepositoryImplementation());

  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonClicked>(_handleRegisterClicked);
  }

  FutureOr<void> _handleRegisterClicked(
      RegisterButtonClicked event, Emitter<RegisterState> emit) async {
    if (event.form.email.isEmpty) {
      emit(RegisterFormError("Email Invalid"));
      return;
    }
    if (event.form.name.isEmpty) {
      emit(RegisterFormError("Name Invalid"));
      return;
    }
    if (event.form.password.isEmpty) {
      emit(RegisterFormError("Password Invalid"));
      return;
    }
    emit(RegisterLoading());
    final res = await _registerUseCase.call(event.form);
    if (res is Success<UserModel>) {
      emit(RegisteredSuccessFully(res.data));
    } else {
      emit(RegisterError(res.error!));
    }
  }
}
