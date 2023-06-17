import 'package:dartz/dartz.dart';
import 'package:my_ecommerce/Home/data/providers/home_network_provider.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Shared/models/network_failure.dart';

class HomeRepository {
  late final HomeNetworkProvider _apiService;

  HomeRepository({required HomeNetworkProvider apiService}) {
    this._apiService = apiService;
  }

  Future<Either<Failure, Product>> fetchDealOfDay() async {
    try {
      final result = await _apiService.getDealOfDay();
      final product = Product.fromMap(result);
      return Right(product);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Product>>> fetchPopular() async {
    try {
      final result = await _apiService.getPopularProducts();
      final products = result.map((product) => Product.fromMap(product));
      return Right(products.toList());
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Product>>> fetchTopRatedProducts() async {
    try {
      final result = await _apiService.getTopRatedProducts();
      final products = result.map((product) => Product.fromMap(product));
      return Right(products.toList());
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Product>>> fetchNewlyAddedProducts() async {
    try {
      final result = await _apiService.getNewlyAddedProducts();
      final products = result.map((product) => Product.fromMap(product));
      return Right(products.toList());
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<String>>> fetchAds() async {
    try {
      final result = await _apiService.getProductsAds();
      final products = result.map((e) => e.toString());
      return Right(products.toList());
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }
}
