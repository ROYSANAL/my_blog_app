part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonClicked extends LoginEvent {
  final LoginForm form;

  LoginButtonClicked(this.form);
}

class AlreadyLoggedIn extends LoginEvent {
  final String uid;

  AlreadyLoggedIn(this.uid);
}
