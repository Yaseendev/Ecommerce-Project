part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersError extends OrdersState {
  final String msg;

  const OrdersError({required this.msg});

  @override
  List<Object> get props => [msg];
}

class OrdersNoInternet extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<Order> orders;

  OrdersLoaded({
    required this.orders,
  });

  @override
  List<Object> get props => [orders];
}
