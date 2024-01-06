part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterFormError extends RegisterState {
  final String error;

  RegisterFormError(this.error);
}

class RegisteredSuccessFully extends RegisterState {
  final UserModel userModel;

  RegisteredSuccessFully(this.userModel);
}

class RegisterError extends RegisterState {
  final String error;

  RegisterError(this.error);
}
