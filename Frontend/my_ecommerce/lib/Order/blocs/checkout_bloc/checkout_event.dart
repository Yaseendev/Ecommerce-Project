part of 'checkout_bloc.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class CheckoutOrder extends CheckoutEvent {
  final Order order;

  const CheckoutOrder({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}
