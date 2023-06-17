import 'package:dartz/dartz.dart';
import 'package:my_ecommerce/Account/data/providers/account_db_provider.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Shared/models/network_failure.dart';
import '../providers/wishlist_network_provider.dart';

class WishlistRepository {
  late final WishlistNetworkProvider _apiService;
  late final AccountDatabaseProvider _accountDatabaseService;

  WishlistRepository({
    required WishlistNetworkProvider apiService,
    required AccountDatabaseProvider accountDatabaseService,
  }) {
    this._apiService = apiService;
    this._accountDatabaseService = accountDatabaseService;
  }

  Future<Either<Failure, List<Product>>> fetchWishlist() async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.getWishlist(token ?? '');
      final products = result.map((pr) => Product.fromMap(pr)).toList();
      return Right(products);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Product>>> addToList(String id) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.addWishlist(token ?? '', id);
      final products = result.map((pr) => Product.fromMap(pr)).toList();
      return Right(products);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Product>>> removeFromList(String id) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.removeWishlist(token ?? '', id);
      final products = result.map((pr) => Product.fromMap(pr)).toList();
      return Right(products);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }
}
