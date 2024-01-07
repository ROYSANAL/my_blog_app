part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class DataAvailable extends ProfileState {
  final UserModel user;

  DataAvailable(this.user);
}

class UserError extends ProfileState {
  final String error;

  UserError(this.error);
}

class LogoutError extends ProfileState {
  final String error;

  LogoutError(this.error);
}

class LogoutSuccessful extends ProfileState {}
class LoggingOut extends ProfileState {}
