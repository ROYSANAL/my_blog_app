part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetUserData extends ProfileEvent {
  final String uid;

  GetUserData(this.uid);
}

class UserDataChanged extends ProfileEvent {
  final UserModel user;

  UserDataChanged(this.user);
}

class UserDataError extends ProfileEvent {
  final String error;

  UserDataError(this.error);
}

class LogOutButtonClicked extends ProfileEvent{}

