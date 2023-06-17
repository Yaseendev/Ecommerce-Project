import 'package:dartz/dartz.dart';
import 'package:my_ecommerce/Shared/models/network_failure.dart';

import '../models/product.dart';
import '../providers/product_network_provider.dart';

class ProductRepository {
  late final ProductNetworkProvider _apiService;

    ProductRepository({required ProductNetworkProvider apiService}) {
    this._apiService = apiService;
  }

    Future<Either<Failure, List<Product>>> fetchRelatedProducts(
      String categId) async {
    try {
      final result = await _apiService.getProducts(categId);
      final products =
          result.map((product) => Product.fromMap(product)).toList();
      return Right(products);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }
  
}