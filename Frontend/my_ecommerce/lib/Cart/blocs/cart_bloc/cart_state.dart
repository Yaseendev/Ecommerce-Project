part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartNoInternet extends CartState {}

class CartError extends CartState {
  final String? msg;

  CartError([this.msg = 'Something went wrong']);

  @override
  List<Object?> get props => [msg];
}

class CartLoaded extends CartState {
  final Cart cart;

  CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
}


