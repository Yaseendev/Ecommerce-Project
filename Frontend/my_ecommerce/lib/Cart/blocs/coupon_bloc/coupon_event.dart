part of 'coupon_bloc.dart';

abstract class CouponEvent extends Equatable {
  const CouponEvent();

  @override
  List<Object> get props => [];
}

class CheckCoupon extends CouponEvent {
  final String code;

  CheckCoupon(this.code);

  @override
  List<Object> get props => [code];
}

class RemoveCoupon extends CouponEvent {

  @override
  List<Object> get props => [];
}
