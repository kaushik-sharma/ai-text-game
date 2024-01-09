import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/constants.dart';

final _retryDio = CustomDio.retryDio;

class CustomDio {
  static const Duration _defaultTimeout = Duration(seconds: 30);
  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: kBaseUrl,
    connectTimeout: _defaultTimeout,
    receiveTimeout: _defaultTimeout,
    sendTimeout: _defaultTimeout,
  );

  static final List<Interceptor> _interceptors = List.unmodifiable(
    [
      PrettyDioLogger(
        requestBody: true,
        responseBody: true,
      ),
      _RetryInterceptor(),
    ],
  );

  static Dio get instance =>
      Dio(_baseOptions)..interceptors.addAll(_interceptors);

  static Dio get retryDio => Dio(_baseOptions)
    ..interceptors.addAll(
      _interceptors.where((interceptor) => interceptor is! _RetryInterceptor),
    );
}

class _RetryInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final int? statusCode = err.response?.statusCode;

    if (statusCode == null ||
        // statusCode < 500 ||
        err.type != DioExceptionType.badResponse) {
      handler.next(err);
      return;
    }

    const int maxRetryCount = 3;
    const List<Duration> retryDelays = [
      Duration.zero,
      Duration(seconds: 1),
      Duration(seconds: 2),
    ];

    for (int i = 0; i < maxRetryCount; i++) {
      final delay = retryDelays[i];

      log('Retrying request "${err.requestOptions.path}" in ${delay.inSeconds} second(s)...');

      await Future.delayed(delay);

      try {
        final res = await _retryDio.request(
          err.requestOptions.path,
          data: err.requestOptions.data,
          cancelToken: err.requestOptions.cancelToken,
          onReceiveProgress: err.requestOptions.onReceiveProgress,
          onSendProgress: err.requestOptions.onSendProgress,
          queryParameters: err.requestOptions.queryParameters,
          options: Options(
            sendTimeout: err.requestOptions.sendTimeout,
            receiveTimeout: err.requestOptions.receiveTimeout,
            contentType: err.requestOptions.contentType,
            extra: err.requestOptions.extra,
            followRedirects: err.requestOptions.followRedirects,
            headers: err.requestOptions.headers,
            listFormat: err.requestOptions.listFormat,
            maxRedirects: err.requestOptions.maxRedirects,
            method: err.requestOptions.method,
            persistentConnection: err.requestOptions.persistentConnection,
            receiveDataWhenStatusError:
                err.requestOptions.receiveDataWhenStatusError,
            requestEncoder: err.requestOptions.requestEncoder,
            responseDecoder: err.requestOptions.responseDecoder,
            responseType: err.requestOptions.responseType,
            validateStatus: err.requestOptions.validateStatus,
          ),
        );

        handler.resolve(res);
        return;
      } catch (_) {}
    }

    handler.next(err);
  }
}
