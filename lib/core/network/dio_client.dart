import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'log_interceptor.dart';

class DioClient{
  static Dio? dio;

  static Dio get instance{
    dio ??= createDio();
    return dio! ;
}

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        queryParameters: {'api_key': ApiConstants.apiKey},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10)
      )
    );
    assert((){
      dio.interceptors.add(AppLogInterceptor());
      return true;
    }());
    return dio;
  }
}