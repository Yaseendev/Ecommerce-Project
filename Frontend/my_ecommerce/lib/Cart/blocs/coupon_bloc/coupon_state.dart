part of 'coupon_bloc.dart';

abstract class CouponState extends Equatable {
  const CouponState();
  
  @override
  List<Object?> get props => [];
}

class CouponInitial extends CouponState {}

class CouponLoading extends CouponState {}

class CouponNoInternet extends CouponState {}

class CouponValid extends CouponState {
  final Cart cart;

  CouponValid(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CouponFailed extends CouponState {
  final String msg;

  CouponFailed({required this.msg});

  @override
  List<Object> get props => [msg];
}