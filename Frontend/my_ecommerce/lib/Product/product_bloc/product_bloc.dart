import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Product/data/repositories/product_repo.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';
import '../data/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final ProductRepository productRepository =
        locator.get<ProductRepository>();
    on<FetchRelatedProducts>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(ProductLoading());
        await productRepository
            .fetchRelatedProducts(event.product.category.id)
            .then((value) => value.fold(
              (l) => emit(ProductError()),
               (prods) {
                  emit(ProductLoaded(
                      products: prods
                          .where((element) => element.id != event.product.id)
                          .toList()));
                }));
      } else {
        emit(ProductNoInternet());
      }
    });
  }
}
