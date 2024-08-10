import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:renweather/core/core.dart';

const _seconds60 = Duration(seconds: 60);

final _customInterceptor = AwesomeDioInterceptor(
  logRequestTimeout: false,
  logRequestHeaders: false,
  logResponseHeaders: false,
);

const _rType = ResponseType.json;

class HTTP {
  static final Dio _dio = Dio(
    BaseOptions(
      responseType: _rType,
      baseUrl: baseUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      connectTimeout: _seconds60,
      receiveTimeout: _seconds60,
    ),
  )..interceptors.add(_customInterceptor);

  static void clearHeaders() {
    _dio.options.headers.clear();
    headerLog.clear();
  }

  static String get baseUrl => EnvironmentSetup.baseUrl;

  static List<String> headerLog = [];

  static void addHeader({
    required String key,
    required String value,
  }) {
    _dio.options.headers[key] = value;
    headerLog.add("$key: $value");
  }

  static Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters ?? {},
    );
    return response;
  }
}
