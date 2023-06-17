import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Order/data/models/order.dart';
import 'package:my_ecommerce/Order/data/repositories/order_repository.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final OrderRepository orderRepository = locator.get<OrderRepository>();
    on<GetOrders>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(OrdersLoading());
        await orderRepository
            .fetchOrders()
            .then((res) => res.fold(
                    (left) => emit(OrdersError(msg: left.message)), (right) {
                  emit(OrdersLoaded(orders: right.reversed.toList()));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(OrdersError(msg: error.toString()));
        });
      } else {
        emit(OrdersNoInternet());
      }
    });
  }
}
