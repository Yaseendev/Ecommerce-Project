part of 'account_bloc.dart';

abstract class AccountState{
  const AccountState();

}

class AccountInitial extends AccountState {

}

class AccountLoggedIn extends AccountState {
final User user;

  AccountLoggedIn(this.user);
}

class AccountError extends AccountState {
 final String? msg;

  AccountError([this.msg]);

  
}

class AccountNoInternet extends AccountState {


}

class AccountLoading extends AccountState {


}
class AccountEmailSent extends AccountState {

}

class AccountLoggedout extends AccountState {}