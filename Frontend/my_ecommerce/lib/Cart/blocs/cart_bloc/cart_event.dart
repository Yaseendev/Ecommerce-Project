part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddItem extends CartEvent {
  final Cart cart;

  AddItem(this.cart);

  @override
  List<Object> get props => [cart];
}

class RemoveItem extends CartEvent {
  final String itemId;

  RemoveItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}

class CartRemoveCoupon extends CartEvent {
  final String c;

  CartRemoveCoupon(this.c);

  @override
  List<Object> get props => [c];
}

class CartApplyCoupon extends CartEvent {
  final String c;

  CartApplyCoupon(this.c);

  @override
  List<Object> get props => [c];
}

class CartUpdate extends CartEvent {
  final Cart cart;

  CartUpdate(this.cart);

  @override
  List<Object> get props => [cart];
}

class CartAddMultiItems extends CartEvent {
  final List<CartItem> items;

  CartAddMultiItems(this.items);

  @override
  List<Object> get props => [items];
}

class SetCart extends CartEvent {
  final Cart cart;

  SetCart(this.cart);

  @override
  List<Object> get props => [cart];
}

class ResetCart extends CartEvent {
  const ResetCart();

  @override
  List<Object> get props => [];
}

class ClearCart extends CartEvent {
  const ClearCart();

  @override
  List<Object> get props => [];
}
