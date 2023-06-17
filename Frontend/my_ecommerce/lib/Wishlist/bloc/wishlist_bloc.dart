import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';
import '../data/repositories/wishlist_repo.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial(null)) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final WishlistRepository _wishlistRepository =
        locator.get<WishlistRepository>();

    on<GetWishList>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(WishlistLoading(state.products));
        await _wishlistRepository
            .fetchWishlist()
            .then((res) =>
                res.fold((left) => emit(WishlistError(state.products, left.message)), (right) {
                  emit(WishlistLoaded(right));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(WishlistError(state.products, error.toString()));
        });
      } else {
        emit(WishlistNoInternet(state.products));
      }
    });

    on<AddToWishlist>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(WishlistLoading(state.products, event.item.id));
        await _wishlistRepository
            .addToList(event.item.id.toString())
            .then((res) =>
                res.fold((left) => emit(WishlistError(state.products, left.message)), (right) {
                  emit(WishlistLoaded(right));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(WishlistError(state.products, error.toString()));
        });
      } else {
        emit(WishlistNoInternet(state.products));
      }
    });

    on<RemoveFromlist>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(WishlistLoading(state.products, event.itemId));
        await _wishlistRepository
            .removeFromList(event.itemId)
            .then((res) =>
                res.fold((left) => emit(WishlistError(state.products, left.message)), (right) {
                  emit(WishlistLoaded(right));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(WishlistError(state.products, error.toString()));
        });
      } else {
        emit(WishlistNoInternet(state.products));
      }
    });

    on<ResetWishlist>((event, emit) {
      emit(WishlistInitial(state.products));
    });
  }
}
