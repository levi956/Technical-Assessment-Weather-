import 'package:dio/dio.dart';

import 'base_notifier.dart';

class ServiceResponse<T> {
  String? message;
  bool error;
  T? data;

  ServiceResponse({this.data, this.message, required this.error});

  NotifierState<T> toNotifierState() {
    return NotifierState<T>(
      status: !error ? NotifierStatus.done : NotifierStatus.error,
      message: message,
      data: data,
    );
  }
}

ServiceResponse<T> serveError<T>({required String error}) {
  return ServiceResponse<T>(
    error: true,
    message: error,
  );
}

ServiceResponse<T> serveData<T>({required T? value, String? message}) {
  return ServiceResponse<T>(
    error: false,
    data: value,
    message: message,
  );
}

typedef FutureHandler<T> = Future<ServiceResponse<T>>;

Future<ServiceResponse<T>> serveFuture<T>({
  required Future<T> Function(Fail fail) function,
  String Function(Object e)? handleError,
  String Function(T response)? handleData,
}) async {
  try {
    final T response = await function(_fail);
    String? message;
    if (handleData != null) {
      message = handleData(response);
    }
    return serveData<T>(value: response, message: message);
  } on DioException catch (e) {
    return serveError<T>(error: _mapDioResponseError(e));
  } on ServeException catch (e) {
    return serveError<T>(error: e.message);
  } on TypeError catch (e) {
    return serveError(error: "Type error $e");
  } catch (e) {
    String error = handleError == null ? e.toString() : handleError(e);
    return serveError<T>(error: error);
  }
}

class ServeException implements Exception {
  late final String message;

  ServeException(String? message) {
    this.message = message ?? "Something went wrong";
  }

  factory ServeException.fromResponse(Response r) {
    return ServeException(_mapResponseToString(r));
  }
}

String _mapResponseToString(Response r) {
  switch (r.data.runtimeType) {
    case const (Map):
      final message = r.data?["message"];
      return message ?? defaultError;
    default:
      return defaultError;
  }
}

typedef Fail = Function(String message, {Response? response});

Never _fail(String message, {Response? response}) {
  if (response != null) {
    throw ServeException.fromResponse(response);
  }

  throw ServeException(message);
}

const defaultError = 'Service Temporarily Unavailable!';
const timeoutE = 'Connection Timeout';

typedef FutureResponse<T> = Future<ServiceResponse<T>>;
typedef StreamResponse<T> = Stream<ServiceResponse<T>>;

String _mapDioResponseError(DioException error) {
  if (error.toString().contains("SocketException")) {
    return "No internet";
  }

  if (error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.connectionTimeout) {
    return "Connection timeout";
  }

  if (error.response == null) {
    return defaultError;
  }

  if (error.type == DioExceptionType.connectionError) {
    return "Failed to connect";
  }

  if (error.response!.data == "" && error.response?.statusCode == 500) {
    return defaultError;
  }
  return "Something went wrong";
}
