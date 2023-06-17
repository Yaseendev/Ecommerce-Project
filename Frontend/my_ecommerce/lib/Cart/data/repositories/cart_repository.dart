import 'package:dartz/dartz.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Account/data/providers/account_db_provider.dart';
import 'package:my_ecommerce/Shared/models/network_failure.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/coupon.dart';
import '../providers/cart_db_provider.dart';
import '../providers/cart_network_provider.dart';
import 'package:my_ecommerce/Order/data/models/order.dart' as appOrder;

class CartRepository {
  late final CartNetworkProvider _apiService;
  late final CartDatabaseProvider _databaseService;
  late final AccountDatabaseProvider _accountDatabaseService;

  CartRepository({
    required CartNetworkProvider apiService,
    required CartDatabaseProvider databaseService,
    required AccountDatabaseProvider accountDatabaseService,
  }) {
    this._apiService = apiService;
    this._databaseService = databaseService;
    this._accountDatabaseService = accountDatabaseService;
  }

  Future<Either<Failure, Cart>> fetchCart([AccountState? accountState]) async {
    if (accountState != null && accountState is! AccountLoggedIn) {
      final cart = await _databaseService.fetchCart();
      return cart == null ? Left(Failure('Database error')) : Right(cart);
    } else {
      try {
        final token = await _accountDatabaseService.getToken();
        final localCart = await _databaseService.fetchCart();
        if (localCart!.cartContent.isNotEmpty) {
          final result = await _apiService.multiAddCart(
              token ?? '', localCart.cartContent);
          final cart = Cart.fromMap(result);
          _databaseService.clearCart();
          return Right(cart);
        }
        final result = await _apiService.getCart(token ?? '');
        final cart = Cart.fromMap(result);
        return Right(cart);
      } catch (e) {
        return Left(Failure(_apiService.getErrorMsg(e)));
      }
    }
  }

  Future<Either<Failure, Cart>> addToCart(CartItem item,
      [AccountState? accountState]) async {
    if (accountState != null && accountState is! AccountLoggedIn) {
      await _databaseService.addToCart(item);
      final cart = await _databaseService.fetchCart();
      return cart == null ? Left(Failure('Database error')) : Right(cart);
    } else {
      try {
        final token = await _accountDatabaseService.getToken();
        final result = await _apiService.addCart(token ?? '', item);
        final cart = Cart.fromMap(result);
        return Right(cart);
      } catch (e) {
        return Left(Failure(_apiService.getErrorMsg(e)));
      }
    }
  }

  Future<Either<Failure, Cart>> multiAddCart(List<CartItem> items) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.multiAddCart(token ?? '', items);
      final cart = Cart.fromMap(result);
      return Right(cart);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, Cart>> updateCart(CartItem item,
      [AccountState? accountState]) async {
    if (accountState != null && accountState is! AccountLoggedIn) {
      await _databaseService.updateCartItem(item);
      final cart = await _databaseService.fetchCart();
      return cart == null ? Left(Failure('Database error')) : Right(cart);
    } else {
      try {
        final token = await _accountDatabaseService.getToken();
        final result = await _apiService.updateCart(token ?? '', item);
        final cart = Cart.fromMap(result);
        return Right(cart);
      } catch (e) {
        return Left(Failure(_apiService.getErrorMsg(e)));
      }
    }
  }

  Future<Either<Failure, Cart>> removeFromCart(String id,
      [AccountState? accountState]) async {
    if (accountState != null && accountState is! AccountLoggedIn) {
      await _databaseService.deleteCartItem(id);
      final cart = await _databaseService.fetchCart();
      return cart == null ? Left(Failure('Database error')) : Right(cart);
    } else {
      try {
        final token = await _accountDatabaseService.getToken();
        final result = await _apiService.removeFromCart(token ?? '', id);
        final cart = Cart.fromMap(result);
        return Right(cart);
      } catch (e) {
        return Left(Failure(_apiService.getErrorMsg(e)));
      }
    }
  }

  Future<Either<Failure, Cart>> applyCoupon(String c) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.applyCoupon(token ?? '', c);
      final cart = Cart.fromMap(result);
      return Right(cart);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, Cart>> removeCoupon() async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.removeCoupon(token ?? '');
      final cart = Cart.fromMap(result);
      return Right(cart);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, bool>> checkout(appOrder.Order order) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.checkoutOrder(token ?? '', order);
      return Right(true);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }
}
