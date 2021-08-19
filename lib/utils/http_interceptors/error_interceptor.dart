import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.cancel:
        err.error = 'Request to API server was cancelled';
        break;
      case DioErrorType.connectTimeout:
        err.error = 'Connection to API server timed out';
        break;
      case DioErrorType.receiveTimeout:
        err.error = 'Receive timeout in connection with API server';
        break;
      case DioErrorType.sendTimeout:
        err.error = 'Send timeout in connection with API server';
        break;
      case DioErrorType.response:
        if (err.response!.data != null) {
          if (err.response!.data is String) {
            err.error = '${err.response!.statusCode}: ${err.response!.data}';
          } else {
            err.error = err.response!.data['message'];
          }
          if (err.response!.statusCode == 404 && err.response!.data is String) {
            err.error = '${err.response!.statusCode} Page not found.';
          }
          if (err.response!.statusCode == 500 && err.response!.data is String) {
            err.error = '${err.response!.statusCode} Internal server error.';
          }

          if (err.response!.statusCode == 401) {
            err.error = 'Unauthenticated';
          }
          if (err.response!.statusCode == 403) {
            err.error = 'Unauthorized';
          }
        } else {
          err.error =
              'Received invalid status code: ${err.response!.statusCode}';
        }
        break;

      case DioErrorType.other:
        err.error =
            'Connection to API server failed due to internet connection';
        break;
    }
    handler.next(err);
  }
}
