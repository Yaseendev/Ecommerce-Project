import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Cart/data/models/cart.dart';
import 'package:my_ecommerce/Cart/data/models/coupon.dart';
import 'package:my_ecommerce/Cart/data/repositories/cart_repository.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(CouponInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final CartRepository _cartRepo = locator.get<CartRepository>();
    on<CheckCoupon>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CouponLoading());
        await _cartRepo.applyCoupon(event.code).then((value) {
          value.fold((left) => emit(CouponFailed(msg: left.message)), (right) {
            emit(CouponValid(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CouponFailed(msg: error.toString()));
        });
      } else {
        emit(CouponNoInternet());
      }
    });

    on<RemoveCoupon>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CouponLoading());
        await _cartRepo.removeCoupon().then((value) {
          value.fold((left) => emit(CouponFailed(msg: left.message)), (right) {
            emit(CouponValid(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CouponFailed(msg: error.toString()));
        });
      } else {
        emit(CouponNoInternet());
      }
    });
  }
}
