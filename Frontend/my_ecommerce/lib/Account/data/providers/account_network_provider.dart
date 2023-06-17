import 'dart:io';
import 'package:dio/dio.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/services/api_service.dart';
import '../models/name.dart';
import '../models/user.dart';

class AccountNetworkProvider extends ApiService {
  Future<Map<String, dynamic>> signup(User user, String password) async {
    final Response response = await dio.post(
      Urls.SIGNUP_API,
      data: {
        ...user.toMap(),
        'password': password,
      },
    );
    return response.data;
  }

  Future<dynamic> checkToken(String token) async {
    final Response response = await dio.post(
      Urls.TOKEN_CHECK_API,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> signin(String email, String password) async {
    final Response response = await dio.post(
      Urls.SIGNIN_API,
      data: {
        'email': email,
        'password': password,
      },
    );
    return response.data;
  }

  Future<Map<String, dynamic>> resetPassword(String email) async {
    final Response response = await dio.post(
      //Urls.FORGOTPASS_API,
      "",
      data: FormData.fromMap({
        'email': email,
      }),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> edit(
      String token, String email, Name name) async {
    final Response response = await dio.post(
      Urls.EDIT_USER,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: {
        'email': email,
        ...name.toMap(),
      },
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
