part of 'account_info_bloc.dart';

abstract class AccountInfoState extends Equatable {
  const AccountInfoState();

  @override
  List<Object?> get props => [];
}

class AccountInfoInitial extends AccountInfoState {}

class AccountInfoError extends AccountInfoState {
  final String? msg;

  const AccountInfoError([this.msg]);

  @override
  List<Object?> get props => [msg];
}

class AccountInfoNoInternet extends AccountInfoState {}

class AccountInfoLoading extends AccountInfoState {}

class AccountInfoEdited extends AccountInfoState {
  final User user;

  const AccountInfoEdited({
   required this.user});

  @override
  List<Object?> get props => [user];
}
