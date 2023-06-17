import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce/Account/data/providers/account_db_provider.dart';
import 'package:my_ecommerce/Address/data/models/location_address.dart';
import 'package:my_ecommerce/Shared/models/network_failure.dart';
import '../models/address.dart';
import '../models/location_result.dart';
import '../provider/address_network_provider.dart';

class AddressRepository {
  late final AddressNetworkProvider _apiService;
  late final AccountDatabaseProvider _accountDatabaseService;

  AddressRepository({
    required AddressNetworkProvider apiService,
    required AccountDatabaseProvider accountDatabaseService,
  }) {
    this._apiService = apiService;
    this._accountDatabaseService = accountDatabaseService;
  }

  Future<Either<Failure, List<Address>>> fetchAddresses() async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.getAddresses(token ?? '');
      final addresses =
          result.map((address) => Address.fromMap(address)).toList();
      return Right(addresses);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Address>>> addAddress(Address address) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.addAddress(
          token ?? '', address);
      final addresses =
          result.map((addres) => Address.fromMap(addres)).toList();
      return Right(addresses);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Address>>> editAddress(Address address, int index) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.editAddress(token ?? '', address, index);
      final addresses = result.map((address) => Address.fromMap(address)).toList();
      return Right(addresses);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<Address>>> deleteAddress(int id) async {
    try {
      final token = await _accountDatabaseService.getToken();
      final result = await _apiService.deleteAddress(token ?? '', id);
      final addresses = result.map((address) => Address.fromMap(address)).toList();
      return Right(addresses);
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, List<LocationResult>>> getLoactionSearchResult(
      String text) async {
    try {
      List<dynamic> result = await _apiService.searchLocation(text);
      return Right(result.map((e) => LocationResult.fromJson(e)).toList());
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }

  Future<Either<Failure, LocationAddress>> getLocationAddress(
      LatLng location) async {
    try {
      final result = await _apiService.reverseGeoLocation(location);
      return Right(LocationAddress.fromMap(result!));
    } catch (e) {
      return Left(Failure(_apiService.getErrorMsg(e)));
    }
  }
}
