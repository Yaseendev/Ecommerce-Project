import 'package:dartz/dartz.dart';
import 'package:my_ecommerce/Shared/models/network_failure.dart';
import '../models/name.dart';
import '../models/user.dart';
import '../providers/account_db_provider.dart';
import '../providers/account_network_provider.dart';

class AccountRepository {
  late final AccountNetworkProvider _apiService;
  late final AccountDatabaseProvider _databaseService;

  AccountRepository(
      {required AccountNetworkProvider networkProvider,
      required AccountDatabaseProvider databaseProvider}) {
    this._apiService = networkProvider;
    this._databaseService = databaseProvider;
  }

  Future<Either<Failure, User>> signupUser(User user, String password) async {
    try {
      final result = await _apiService.signup(user, password);
      await _databaseService.setToken(result['token']);
      final appUser = User.fromMap(result['user']);
      await _databaseService.setUser(appUser);
      return Right(appUser);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, User>> signinUser(
      String email, String password) async {
    try {
      final result = await _apiService.signin(email, password);
      await _databaseService.setToken(result['token']);
      final appUser = User.fromMap(result['user']);
      await _databaseService.setUser(appUser);
      return Right(appUser);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, dynamic>> resetPassword(String email) async {
    try {
      final result = await _apiService.resetPassword(email);
      return Right(result);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, User>> tokenCheck() async {
    try {
      if (!(_databaseService.prefs?.getBool('hasRunBefore') ?? false)) {
        _databaseService.secureStorage.deleteAll();
        _databaseService.prefs?.setBool('hasRunBefore', true);
        return Left(Failure('No Token'));
      }
      final token = await _databaseService.getToken();
      if (token == null) return Left(Failure('No Token'));
      final result = await _apiService.checkToken(token);
      final appUser = User.fromMap(result['user']);
      await _databaseService.setUser(appUser);
      return Right(appUser);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, User>> editUser(User user) async {
    try {
      final token = await _databaseService.getToken();
      final result = await _apiService.edit(token ?? '', user.email, user.name);
      final appUser = User.fromMap(result);
      await _databaseService.setUser(appUser);
      return Right(appUser);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }
}
