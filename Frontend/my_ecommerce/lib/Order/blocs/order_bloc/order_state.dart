part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderError extends OrderState {
  final String msg;

  const OrderError({required this.msg});

  @override
  List<Object> get props => [msg];
}

class OrderNoInternet extends OrderState {}

class OrderLoading extends OrderState {}

class OrderCanceled extends OrderState {

  OrderCanceled();

  @override
  List<Object> get props => [];
}
