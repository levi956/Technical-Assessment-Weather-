import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:renweather/app/modules/weather/data/models/city_location_model.dart';
import 'package:renweather/app/modules/weather/data/models/weather_model.dart';
import 'package:renweather/app/shared/shared.dart';
import 'package:renweather/core/core.dart';

import '../../data/models/get_forecast_model.dart';

// API OR REMOTE DATA SOURCE LAYER
class WeatherService {
  static FutureHandler<WeatherModel> getForecast(GetForecastModel model) {
    return serveFuture<WeatherModel>(
      function: (fail) async {
        final r = await HTTP.get(
          "data/2.5/weather",
          queryParameters: {
            "lat": model.latitude,
            "lon": model.longitude,
            "appid": model.apiKey,
          },
        );
        if (r.is200or201) {
          final body = r.data;
          return WeatherModel.fromJson(body);
        }
        return fail("Error", response: r);
      },
    );
  }

  static FutureHandler<List<CityLocationModel>> getCities() {
    return serveFuture<List<CityLocationModel>>(
      function: (fail) async {
        final data = await rootBundle.loadString(_citiesJsonPath);
        List body = jsonDecode(data);
        return body.map((e) => CityLocationModel.fromJson(e)).toList();
      },
    );
  }

  static FutureHandler<WeatherModel> getLocationForecast() {
    return serveFuture<WeatherModel>(
      function: (fail) async {
        final position = await Geolocator.getCurrentPosition();
        final model = GetForecastModel(
          latitude: "${position.latitude}",
          longitude: "${position.longitude}",
        );
        final r = await HTTP.get(
          "data/2.5/weather",
          queryParameters: {
            "lat": model.latitude,
            "lon": model.longitude,
            "appid": model.apiKey,
          },
        );
        if (r.is200or201) {
          final body = r.data;
          return WeatherModel.fromJson(body);
        }
        return fail("Error", response: r);
      },
    );
  }
}

const _citiesJsonPath = "assets/data/ng.json";
