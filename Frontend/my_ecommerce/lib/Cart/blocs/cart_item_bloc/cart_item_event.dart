part of 'cart_item_bloc.dart';

abstract class CartItemEvent extends Equatable {
  const CartItemEvent();

  @override
  List<Object> get props => [];
}

class AddItemToCart extends CartItemEvent {
  final CartItem item;
  
  const AddItemToCart({
    required this.item,
  });

  @override
  List<Object> get props => [item];
}

class IncreaseQuantity extends CartItemEvent {
  final CartItem item;
  
  const IncreaseQuantity({
    required this.item,
  });

  @override
  List<Object> get props => [item];
}

class DecreaseQuantity extends CartItemEvent {
  final CartItem item;
  
  const DecreaseQuantity({
    required this.item,
  });

  @override
  List<Object> get props => [item];
}

class DeleteItem extends CartItemEvent {
  final String itemId;
  
  const DeleteItem({
    required this.itemId,
  });

  @override
  List<Object> get props => [itemId];
}