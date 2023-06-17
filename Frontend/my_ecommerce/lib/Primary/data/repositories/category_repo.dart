import 'package:dartz/dartz.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Shared/models/network_failure.dart';
import '../models/category.dart';
import '../providers/category_network_provider.dart';

class CategoryRepository {
  late final CategoryNetworkProvider _apiService;

  CategoryRepository({required CategoryNetworkProvider apiService}) {
    this._apiService = apiService;
  }

  Future<Either<Failure, List<Category>>> fetchCategories() async {
    try {
      final result = await _apiService.getCategories();
      final categorise =
          result.map((category) => Category.fromMap(category)).toList();
      return Right(categorise);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Product>>> fetchCategoryProducts(
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
