import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Home/data/repositories/home_repository.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'products_ads_event.dart';
part 'products_ads_state.dart';

class ProductsAdsBloc extends Bloc<ProductsAdsEvent, ProductsAdsState> {
  ProductsAdsBloc() : super(ProductsAdsInitial()) {
     final Connectivity connectivity = locator.get<Connectivity>();
    final HomeRepository repository = locator.get<HomeRepository>();
    on<FetchAds>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(ProductsAdsLoading());
        await repository
            .fetchAds()
            .then((value) => value.fold((l) => emit(ProductsAdsError()), (prods) {
                  emit(ProductsAdsLoaded(ads: prods));
                }));
      }
    });
  }
}
