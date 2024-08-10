import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:renweather/app/modules/weather/data/models/weather_model.dart';
import 'package:renweather/app/modules/weather/domain/repository/weather_repository.dart';
import 'package:renweather/core/core.dart';

final getLocationForecastNotifer =
    NotifierProvider<GetLocationForecastNotifier, NotifierState<WeatherModel>>(
        GetLocationForecastNotifier.new);

class GetLocationForecastNotifier extends BaseNotifier<WeatherModel> {
  @override
  onInit() {
    _getForecast();
    super.onInit();
  }

  Future<void> _getForecast() async {
    setLoading();
    state = await ref.read(weatherRepository).getLocationForecast();
  }
}
