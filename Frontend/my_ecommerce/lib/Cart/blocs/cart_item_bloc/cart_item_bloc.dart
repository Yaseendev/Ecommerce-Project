import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Cart/data/models/cart.dart';
import 'package:my_ecommerce/Cart/data/models/cart_item.dart';
import 'package:my_ecommerce/Cart/data/repositories/cart_repository.dart';
import 'package:my_ecommerce/Utils/services/service_locator.dart';

part 'cart_item_event.dart';
part 'cart_item_state.dart';

class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  CartItemBloc(BuildContext context) : super(CartItemInitial()) {
    final Connectivity connectivity = locator.get<Connectivity>();
    final CartRepository _cartRepo = locator.get<CartRepository>();

    on<AddItemToCart>((event, emit) async {
      if (await connectivity.checkConnectivity() != ConnectivityResult.none) {
        emit(CartItemLoading());
        await _cartRepo
            .addToCart(event.item, context.read<AccountBloc>().state)
            .then((res) {
          res.fold((left) => emit(CartItemError(left.message)), (right) {
            emit(CartItemAdded(cart: right));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartItemError(error.toString()));
        });
      } else {
        emit(CartItemNoInternet());
      }
    });

    on<IncreaseQuantity>((event, emit) async {
      emit(CartItemLoading());
      await _cartRepo
          .updateCart(event.item, context.read<AccountBloc>().state)
          .then((res) {
        res.fold((left) => emit(CartItemError(left.message)), (right) {
          emit(CartItemUpdated(
            item: event.item,
            cart: right,
          ));
        });
      }).onError((error, stackTrace) {
        print(error);
        emit(CartItemError(error.toString()));
      });
    });

    on<DecreaseQuantity>((event, emit) async {
      emit(CartItemLoading());
      if (event.item.quantity == 0) {
        await _cartRepo
            .removeFromCart(
                event.item.product.id, context.read<AccountBloc>().state)
            .then((res) {
          res.fold((left) => emit(CartItemError(left.message)), (right) {
            emit(CartItemDeleted(
              cart: right,
            ));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartItemError(error.toString()));
        });
      } else {
        await _cartRepo
            .updateCart(event.item, context.read<AccountBloc>().state)
            .then((res) {
          res.fold((left) => emit(CartItemError(left.message)), (right) {
            emit(CartItemUpdated(
              item: event.item,
              cart: right,
            ));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartItemError(error.toString()));
        });
      }
    });
    on<DeleteItem>((event, emit) async {
      emit(CartItemLoading());
      await _cartRepo
            .removeFromCart(
                event.itemId, context.read<AccountBloc>().state)
            .then((res) {
          res.fold((left) => emit(CartItemError(left.message)), (right) {
            emit(CartItemDeleted(
              cart: right,
            ));
          });
        }).onError((error, stackTrace) {
          print(error);
          emit(CartItemError(error.toString()));
        });
    });
  }
}
