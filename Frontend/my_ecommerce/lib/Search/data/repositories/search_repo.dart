import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_ecommerce/Product/data/models/product.dart';
import 'package:my_ecommerce/Shared/models/network_failure.dart';
import '../models/search_criteria.dart';
import '../providers/search_database_provider.dart';
import '../providers/search_network_provider.dart';

class SearchRepository {
  late final SearchNetworkProvider _apiService;
  late final SearchDatabaseProvider _searchDatabaseService;

  SearchRepository({
    required SearchNetworkProvider apiService,
    required SearchDatabaseProvider searchDatabaseService,
  }) {
    this._apiService = apiService;
    
    this._searchDatabaseService = searchDatabaseService;
    
  }

  Future<Either<Failure, List<Product>>> searchProducts(
    String term, {
    SearchCriteria? searchCriteria,
  }) async {
    try {
      final result = await _apiService.search(
        term,
        searchCriteria,
      );
      _searchDatabaseService.saveSearch(term);
      return Right(result
          .map((e) => Product.fromMap(e))
          .toList());
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

    Future<Either<Failure, List<String>>> fetchSearchFilter() async {
    try {
      final result = await _apiService.getSearchFilter();
      return Right(result.map((e) => e.toString()).toList());
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, ValueListenable<Box<String>>>>
      fetchSearchHistory() async {
    try {
      final searchBox = await _searchDatabaseService.getHistoryBox();
      return Right(searchBox.listenable());
    } catch (e) {
      return Left(Failure('Could not get search history'));
    }
  }
}
