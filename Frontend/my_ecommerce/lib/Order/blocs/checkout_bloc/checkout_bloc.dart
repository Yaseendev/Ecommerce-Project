import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Cart/data/repositories/cart_repository.dart';
import 'package:my_ecommerce/Order/data/models/order.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final CartRepository _cartRepo = locator.get<CartRepository>();
    on<CheckoutOrder>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CheckoutLoading());
        await _cartRepo.checkout(event.order).then((res) =>
                res.fold((left) => emit(CheckoutFailed(msg: left.message)),
                 (right) {
                  emit(CheckoutSuccess());
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(CheckoutFailed(msg :error.toString()));
        });
        } else {
        emit(CheckoutFailed(msg: 'No Internet Connection'));
      }
    });
  }
}
