import 'package:dartz/dartz.dart';
import 'package:my_ecommerce/Account/data/providers/account_db_provider.dart';
import 'package:my_ecommerce/Shared/models/network_failure.dart';
import '../proivders/order_network_provider.dart';
import 'package:my_ecommerce/Order/data/models/order.dart' as appOrder;

class OrderRepository {
  late final OrderNetworkProvider _apiService;
  late final AccountDatabaseProvider _accountDatabaseService;

   OrderRepository({
    required OrderNetworkProvider apiService,
    required AccountDatabaseProvider accountDatabaseService,
  }) {
    this._apiService = apiService;
    this._accountDatabaseService = accountDatabaseService;
  }

    Future<Either<Failure, List<appOrder.Order>>> fetchOrders() async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.getOrders(token ?? '');
      final orders = result.map((order) => appOrder.Order.fromMap(order)).toList();
      return Right(orders);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

    Future<Either<Failure, dynamic>> cancelOrder(String orderId) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.cancelOrder(token ?? '', orderId);
      return Right(result);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }
}