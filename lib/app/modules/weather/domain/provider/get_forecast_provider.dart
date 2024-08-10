import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:renweather/app/modules/weather/data/models/get_forecast_model.dart';
import 'package:renweather/app/modules/weather/data/models/weather_model.dart';
import 'package:renweather/app/modules/weather/domain/repository/weather_repository.dart';
import 'package:renweather/core/core.dart';

final getForecastProvider =
    NotifierProvider<GetForecastNotifier, NotifierState<WeatherModel>>(
        GetForecastNotifier.new);

class GetForecastNotifier extends BaseNotifier<WeatherModel> {
  //
  Future<void> getForecast(GetForecastModel model) async {
    setLoading();
    state = await ref.read(weatherRepository).getForecast(model);
  }
}
