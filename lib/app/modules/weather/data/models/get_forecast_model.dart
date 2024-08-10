import 'package:renweather/core/core.dart';

class GetForecastModel {
  String longitude;
  String latitude;
  final String _apiKey;

  GetForecastModel({
    required this.latitude,
    required this.longitude,
    String? apiKey,
  }) : _apiKey = apiKey ?? EnvPath.apiKey;

  String get apiKey => _apiKey;
}
