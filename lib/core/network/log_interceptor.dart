import 'package:dio/dio.dart';

import '../utils/debug_logger.dart';

class AppLogInterceptor extends Interceptor{
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler){
    DebugLogger.request('URL: ${options.uri}');
    DebugLogger.request('HEADERS: ${options.headers}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler){
    DebugLogger.response('STATUS: ${response.statusCode}');
    DebugLogger.response('DATA: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler){
    DebugLogger.response('ERROR: ${error.message}');
    handler.next(error);
  }
}
