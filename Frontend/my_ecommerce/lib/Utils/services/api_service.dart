import 'package:dio/dio.dart';
import '../constants.dart';

abstract class ApiService {
  late final Dio dio;
  ApiService() {
    this.dio = Dio(BaseOptions(
      contentType: 'application/json',
      baseUrl: Urls.BASE_API,
    ));
  }

  String getErrorMsg(Object error);
}
