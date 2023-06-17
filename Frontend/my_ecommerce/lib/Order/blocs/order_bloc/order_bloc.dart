import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Order/data/repositories/order_repository.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final OrderRepository orderRepository = locator.get<OrderRepository>();
    on<CancelOrder>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(OrderLoading());
        await orderRepository
            .cancelOrder(event.id)
            .then((res) => res.fold(
                    (left) => emit(OrderError(msg: left.message)), (right) {
                  emit(OrderCanceled());
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(OrderError(msg: error.toString()));
        });
      } else {
        emit(OrderNoInternet());
      }
    });
  }
}
