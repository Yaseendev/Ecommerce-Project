import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Home/data/repositories/home_repository.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'top_products_event.dart';
part 'top_products_state.dart';

class TopProductsBloc extends Bloc<TopProductsEvent, TopProductsState> {
  TopProductsBloc() : super(TopProductsInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final HomeRepository repository = locator.get<HomeRepository>();
    on<FetchTopRated>((event, emit) async {
            if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(TopProductsLoading());
        await repository
            .fetchTopRatedProducts()
            .then((value) => value.fold((l) => emit(TopProductsError()), (prods) {
                  emit(TopProductsLoaded(products: prods));
                }));
      }
    });
  }
}
