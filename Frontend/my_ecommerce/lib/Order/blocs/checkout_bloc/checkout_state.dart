part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {
  const CheckoutState();
  
  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}
class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {

  @override
  List<Object?> get props => [];
}

class CheckoutFailed extends CheckoutState {
  final String msg;

  CheckoutFailed({required this.msg});

  @override
  List<Object> get props => [msg];
}