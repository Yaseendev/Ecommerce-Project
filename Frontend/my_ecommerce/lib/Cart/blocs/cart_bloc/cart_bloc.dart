import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Cart/data/models/cart.dart';
import 'package:my_ecommerce/Cart/data/models/cart_item.dart';
import 'package:my_ecommerce/Cart/data/repositories/cart_repository.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  Cart? cart;
  CartBloc(BuildContext context) : super(CartInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final CartRepository _cartRepo = locator.get<CartRepository>();
    on<GetCart>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartLoading());
        await _cartRepo
            .fetchCart(context.read<AccountBloc>().state)
            .then((res) =>
                res.fold((left) => emit(CartError(left.message)), (right) {
                  cart = right;
                  emit(CartLoaded(right));
                }))
            .onError((error, stackTrace) {
          print(error);
          emit(CartError(error.toString()));
        });
      } else {
        emit(CartNoInternet());
      }
    });

    on<AddItem>((event, emit) async {
      emit(CartLoading());
      cart = event.cart;
      emit(CartLoaded(event.cart));
      // if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      //   emit(CartLoading());
      //   await _cartRepo.addToCart(event.item).then((res) {
      //     res.fold((left) => emit(CartError(left.message)), (right) {
      //       emit(CartLoaded(right));
      //     });
      //   }).onError((error, stackTrace) {
      //     print(error);
      //     emit(CartError(error.toString()));
      //   });
      // } else {
      //   emit(CartNoInternet());
      // }
    });

    on<RemoveItem>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartLoading());
        await _cartRepo.removeFromCart(event.itemId, context.read<AccountBloc>().state).then((res) {
          res.fold((left) => emit(CartError(left.message)), (right) {
            emit(CartLoaded(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartError(error.toString()));
        });
      } else {
        emit(CartNoInternet());
      }
    });

    // on<CartRemoveCoupon>((event, emit) async {
    //   if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
    //     emit(CartLoading());
    //     await _cartRepo.removeCoupon(event.c).then((res) {
    //       res.fold((left) => emit(CartError(left.message)), (right) {
    //         emit(CartLoaded(right));
    //       });
    //     }).onError((error, stackTrace) {
    //       print(error);
    //       emit(CartError(error.toString()));
    //     });
    //   } else {
    //     emit(CartNoInternet());
    //   }
    // });

    // on<CartApplyCoupon>((event, emit) async {
    //   if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
    //     emit(CartLoading());
    //     await _cartRepo.applyCoupon(event.c).then((res) {
    //       res.fold((left) => emit(CartError(left.message)), (right) {
    //         emit(CartLoaded(right));
    //       });
    //     }).onError((error, stackTrace) {
    //       print(error);
    //       emit(CartError(error.toString()));
    //     });
    //   } else {
    //     emit(CartNoInternet());
    //   }
    // });

    on<CartUpdate>((event, emit) async {
       //emit(CartLoading());
      cart = event.cart;
      emit(CartLoaded(event.cart.copyWith(
cartContent: List.of(event.cart.cartContent),
      )));
      // if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
      //   emit(CartLoading());
      //   await _cartRepo.updateCart(event.item).then((res) {
      //     res.fold((left) => emit(CartError(left.message)), (right) {
      //       cart = right;
      //       emit(CartLoaded(right));
      //     });
      //   }).onError((error, stackTrace) {
      //     print(error);
      //     emit(CartError(error.toString()));
      //   });
      // } else {
      //   emit(CartNoInternet());
      // }
    });

    on<CartAddMultiItems>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartLoading());
        await _cartRepo.multiAddCart(event.items).then((res) {
          res.fold((left) => emit(CartError(left.message)), (right) {
            emit(CartLoaded(right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartError(error.toString()));
        });
      } else {
        emit(CartNoInternet());
      }
    });

    on<SetCart>((event, emit) {
      cart = event.cart;
      emit(CartLoaded(event.cart));
    });

    on<ResetCart>((event, emit) {
      cart = null;
      emit(CartInitial());
    });
    
    on<ClearCart>((event, emit) {
      emit(CartLoading());
      cart = Cart(cartContent: [], total: 0, subtotal: 0);
      emit(CartLoaded(
        cart!
      ));
    });
  }
}
