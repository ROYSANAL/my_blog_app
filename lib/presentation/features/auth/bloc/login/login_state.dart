part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoggedInSuccessfully extends LoginState {
  final UserModel user;

  LoggedInSuccessfully(this.user);
}

class LoginFormError extends LoginState{
  final String error;

  LoginFormError(this.error);
}

class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}


