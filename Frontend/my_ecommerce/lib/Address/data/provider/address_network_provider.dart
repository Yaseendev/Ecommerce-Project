import 'dart:io';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/services/api_service.dart';
import '../models/address.dart';

class AddressNetworkProvider extends ApiService {
  
  Future<List<dynamic>> getAddresses(String token) async {
    final Response response = await dio.get(
      Urls.GET_ADDRESSES,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response.data;
  }

  Future<List<dynamic>> addAddress(String token, Address address) async {
    final Response response = await dio.post(
      Urls.ADD_ADDRESS,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: address.toMap(),
    );
    return response.data;
  }

  Future<List<dynamic>> editAddress(String token, Address address, int index) async {
    final Response response = await dio.post(
      Urls.EDIT_ADDRESS,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: {
        'index': index,
        'address': address.toMap(),
        },
    );
    return response.data;
  }

  Future<List<dynamic>> deleteAddress(String token, int addressId) async {
    final Response response = await dio.delete(
      Urls.GET_ADDRESSES,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: addressId,
    );
    return response.data;
  }

 Future<dynamic> searchLocation(String text) async {
    Response response = await Dio(
      BaseOptions(baseUrl: Urls.LOCATION_BASE_API)
    ).get(
      Urls.LOCATION_AUTOCOMPLETE,
      options: Options(
        contentType: 'application/json',
      ),
      queryParameters: {
        'q': text,
        'key': locationKey,
      },
    );
    return response.data;
  }

    Future<Map<String, dynamic>?> reverseGeoLocation(LatLng location) async {
    Response response = await Dio(
      BaseOptions(baseUrl: Urls.LOCATION_BASE_API)
    ).get(
      Urls.LOCATION_REVERSE,
      queryParameters: {
        'lat': location.latitude,
        'lon': location.longitude,
        'key': locationKey,
        'format': 'json',
      },
      options: Options(
        contentType: 'application/json',
      ),
    );
    return response.data;
  }

  @override //TODO: Refactor
  String getErrorMsg(Object error) {
    if (error is Exception) {
      try {
        String networkException = '';
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkException = 'Server connection canceled';
              break;
            case DioErrorType.connectionTimeout:
              networkException = 'No Internet Connection';
              break;
            case DioErrorType.unknown:
              networkException = 'No Internet Connection';
              break;
            case DioErrorType.receiveTimeout:
              networkException =
                  'Receive timeout in connection with API server';
              break;
            case DioErrorType.badResponse:
              if (error.error.toString().contains('XMLHttpRequest')) {
                networkException = 'Cannot connect to the server';
              } else
                switch (error.response!.statusCode) {
                  case 400:
                    try {
                      networkException = error.response!.data.toString();
                    } catch (e) {
                      networkException = 'Somethig went wrong';
                    }
                    break;
                  case 401:
                    networkException = 'Unauthorised client';
                    break;
                  case 403:
                    networkException = 'Unauthorised request';
                    break;
                  case 404:
                    try {
                      networkException = error.response!.data['message'];
                    } catch (e) {
                      networkException = 'Somethig went wrong';
                    }
                    break;
                  case 406:
                    try {
                      networkException = error.response!.data['message'];
                    } catch (e) {
                      networkException = 'Somethig went wrong';
                    }
                    break;
                  case 409:
                    try {
                      networkException = error.response!.data['message'];
                    } catch (e) {
                      networkException = 'Somethig went wrong';
                    }
                    break;
                  case 408:
                    try {
                      networkException = error.response!.data['message'];
                    } catch (e) {
                      networkException = 'Somethig went wrong';
                    }
                    break;
                  case 500:
                    try {
                      networkException = error.response!.data['message'];
                    } catch (e) {
                      networkException = 'Internal Server Error';
                    }
                    break;
                  case 503:
                    networkException = 'Service is unavailable at the moment';
                    break;
                  default:
                    networkException = error.message ?? '';
                }
              break;
            case DioErrorType.sendTimeout:
              networkException = 'Send timeout in connection with API server';
              break;
            case DioErrorType.badCertificate:
              // TODO: Handle this case.
              break;
            case DioErrorType.connectionError:
              // TODO: Handle this case.
              break;
          }
        } else if (error is SocketException) {
          networkException = 'No Internet Connection';
        } else {
          networkException = 'Unexpected error occurred ${error.toString()}';
        }
        return networkException;
      } on FormatException {
        return 'Unexpected error occurred ${error.toString()}';
      } catch (e) {
        return 'No Internet Connection';
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return 'Unable to process the data';
      } else {
        return 'Unexpected error occurred ${error.toString()}';
      }
    }
  }

}
