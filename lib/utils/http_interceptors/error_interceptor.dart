import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    DioError dioError = err;
    switch (err.type) {
      case DioErrorType.cancel:
        dioError = err.copyWith(error: 'Request to API server was cancelled');
        break;
      case DioErrorType.connectionTimeout:
        dioError = err.copyWith(error: 'Connection to API server timed out');
        break;
      case DioErrorType.receiveTimeout:
        dioError = err.copyWith(
          error: 'Receive timeout in connection with API server',
        );
        break;
      case DioErrorType.sendTimeout:
        dioError = err.copyWith(
          error: 'Send timeout in connection with API server',
        );
        break;
      case DioErrorType.badResponse:
        if (err.response!.data != null) {
          if (err.response!.data is String) {
            dioError = err.copyWith(
                error: '${err.response!.statusCode}: ${err.response!.data}');
          } else if (err.response!.data is List) {
            dioError = err.copyWith(
                error: err.response!.data
                    .map((el) => '${el['message']}\n')
                    .toList()
                    .join());
          } else {
            dioError =
                err.copyWith(error: err.response!.data['message'].toString());
          }
          if (err.response!.statusCode == 404 && err.response!.data is String) {
            dioError = err.copyWith(
                error: '${err.response!.statusCode} Resource not found.');
          }
          if (err.response!.statusCode == 500 && err.response!.data is String) {
            dioError = err.copyWith(
                error: '${err.response!.statusCode} Internal server error.');
          }
        } else {
          dioError = err.copyWith(
            error: 'Received invalid status code: ${err.response!.statusCode}',
          );
        }
        break;
      case DioErrorType.badCertificate:
        dioError = err.copyWith(error: 'Certificate validation failed');
        break;
      case DioErrorType.connectionError:
        dioError = err.copyWith(
          error: 'Connection to API server failed due to internet connection',
        );
        break;
      case DioErrorType.unknown:
        dioError = err.copyWith(
          error: 'Connection to API server failed due to unknown error',
        );
        break;
    }
    return handler.next(dioError);
  }
}
