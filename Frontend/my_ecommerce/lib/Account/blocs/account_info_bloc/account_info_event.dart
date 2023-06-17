// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_info_bloc.dart';

abstract class AccountInfoEvent extends Equatable {
  const AccountInfoEvent();

  @override
  List<Object> get props => [];
}

class EditAccount extends AccountInfoEvent {
  final User user;

  const EditAccount({
    required this.user,
  });
  
  @override
  List<Object> get props => [user];
}
