// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class SingUpEvent extends AccountEvent {
  final String email;
  final Name name;
  final String password;
  SingUpEvent({
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  List<Object> get props => [email, name, password];
}

class SingInEvent extends AccountEvent {
  final String email;
  final String password;

  SingInEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LoadUserProfileEvent extends AccountEvent {
  final User user;

  LoadUserProfileEvent({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class ResetPasswordEvent extends AccountEvent {
  final String email;

  ResetPasswordEvent({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}
