part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class CancelOrder extends OrderEvent {
  final String id;

  CancelOrder({
    required this.id,
  });
  
  @override
  List<Object> get props => [id];
}