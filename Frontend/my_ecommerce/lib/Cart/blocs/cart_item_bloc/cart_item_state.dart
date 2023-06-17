part of 'cart_item_bloc.dart';

abstract class CartItemState extends Equatable {
  const CartItemState();

  @override
  List<Object?> get props => [];
}

class CartItemInitial extends CartItemState {}

class CartItemLoading extends CartItemState {}

class CartItemNoInternet extends CartItemState {}

class CartItemError extends CartItemState {
  final String? msg;

  CartItemError([this.msg = 'Something went wrong']);

  @override
  List<Object?> get props => [msg];
}

class CartItemAdded extends CartItemState {
  final Cart cart;

  CartItemAdded({
    required this.cart,
  });

  @override
  List<Object?> get props => [cart];
}

class CartItemUpdated extends CartItemState {
  final Cart cart;
  final CartItem item;

  CartItemUpdated({
    required this.cart,
    required this.item,
  });

  @override
  List<Object?> get props => [cart, item];
}

class CartItemDeleted extends CartItemState {
  final Cart cart;

  CartItemDeleted({
    required this.cart,
  });

  @override
  List<Object?> get props => [cart];
}
