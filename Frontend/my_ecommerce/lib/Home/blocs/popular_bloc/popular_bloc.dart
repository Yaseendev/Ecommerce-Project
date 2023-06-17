import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Home/data/repositories/home_repository.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  PopularBloc() : super(PopularInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final HomeRepository repository = locator.get<HomeRepository>();
    on<LoadMostPopular>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(PopularLoading());
        await repository
            .fetchPopular()
            .then((value) => value.fold((l) => emit(PopularError()), (prods) {
                  emit(PopularLoaded(products: prods));
                }));
      }
    });
  }
}
