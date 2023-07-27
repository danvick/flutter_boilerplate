import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    var dioError = err;
    switch (err.type) {
      case DioExceptionType.cancel:
        dioError = err.copyWith(error: 'Request to API server was cancelled');
      case DioExceptionType.connectionTimeout:
        dioError = err.copyWith(error: 'Connection to API server timed out');
      case DioExceptionType.receiveTimeout:
        dioError = err.copyWith(
          error: 'Receive timeout in connection with API server',
        );
      case DioExceptionType.sendTimeout:
        dioError = err.copyWith(
          error: 'Send timeout in connection with API server',
        );
      case DioExceptionType.badResponse:
        if (err.response!.data != null) {
          if (err.response!.data is String) {
            dioError = err.copyWith(
              error: '${err.response!.statusCode}: ${err.response!.data}',
            );
          } else {
            dioError = err.copyWith(error: err.response.toString());
          }
          if (err.response!.statusCode == 404) {
            dioError = err.copyWith(
              error: '${err.response!.statusCode}: Resource not found.',
            );
          }
          if (err.response!.statusCode == 500) {
            dioError = err.copyWith(
              error: '${err.response!.statusCode}: Internal server error.',
            );
          }
        } else {
          dioError = err.copyWith(
            error: 'Received invalid status code: ${err.response!.statusCode}',
          );
        }
      case DioExceptionType.badCertificate:
        dioError = err.copyWith(error: 'Certificate validation failed');
      case DioExceptionType.connectionError:
        dioError = err.copyWith(
          error: 'Connection to API server failed due to internet connection',
        );
      case DioExceptionType.unknown:
        dioError = err.copyWith(
          error: 'Connection to API server failed due to unknown error',
        );
    }
    return handler.next(dioError);
  }
}
