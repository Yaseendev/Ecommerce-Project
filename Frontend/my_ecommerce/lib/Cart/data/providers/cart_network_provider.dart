import 'dart:io';
import 'package:dio/dio.dart';
import 'package:my_ecommerce/Order/data/models/order.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/services/api_service.dart';
import '../models/cart_item.dart';

class CartNetworkProvider extends ApiService {
  Future<Map<String, dynamic>> getCart(String token) async {
    final Response response = await dio.get(
      Urls.GET_CART,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> addCart(String token, CartItem item) async {
    final Response response = await dio.post(
      Urls.ADD_CART,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: item.toMap(),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> multiAddCart(
      String token, List<CartItem> items) async {
    final Response response = await dio.post(
      Urls.ADD_CART_BULK,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: {'items': items.map((e) => e.toMap()).toList()},
    );
    return response.data;
  }

  Future<Map<String, dynamic>> updateCart(String token, CartItem item) async {
    final Response response = await dio.post(
      Urls.UPDATE_CART,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: item.toMap(),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> removeFromCart(
      String token, String itemId) async {
    final Response response = await dio.post(
      Urls.REMOVE_CART,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: itemId,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> applyCoupon(String token, String c) async {
    final Response response = await dio.get(
      Urls.COUPON_PATH,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      queryParameters: {
        'code': c,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> removeCoupon(String token) async {
    final Response response = await dio.post(
      Urls.REMOVE_COUP_CART,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response.data;
  }

  Future<List<dynamic>> checkoutOrder(String token, Order order) async {
    final orderMap = order.toMap();
    final Response response = await dio.post(
      Urls.CHECKOUT,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: orderMap,
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
                      networkException = error.response!.data;
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
