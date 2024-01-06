part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterButtonClicked extends RegisterEvent{
  final SignUpForm form;

  RegisterButtonClicked(this.form);
}
