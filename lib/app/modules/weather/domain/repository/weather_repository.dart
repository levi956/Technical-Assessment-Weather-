import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:renweather/app/modules/weather/data/models/city_location_model.dart';
import 'package:renweather/app/modules/weather/data/models/get_forecast_model.dart';
import 'package:renweather/app/modules/weather/data/models/weather_model.dart';
import 'package:renweather/app/modules/weather/domain/provider/persisted_locations_provider.dart';
import 'package:renweather/app/modules/weather/domain/service/weather_service.dart';
import 'package:renweather/core/core.dart';

final weatherRepository = Provider<WeatherRepository>((ref) {
  return WeatherRepository(ref);
});

class WeatherRepository {
  ProviderRef ref;

  WeatherRepository(this.ref);

  FutureNotifierState<WeatherModel> getForecast(GetForecastModel model) {
    return convertWithArgument<WeatherModel, GetForecastModel>(
      WeatherService.getForecast,
      model,
      then: (response) {
        if (response.error) return;
        final weather_ = response.data!;
        ref.read(localCitiesProvider.notifier).addDataToMap(weather_);
      },
    );
  }

  FutureNotifierState<List<CityLocationModel>> getCities() {
    return convert<List<CityLocationModel>>(
      WeatherService.getCities,
      then: (response) {
        if (response.error) return;
        final data = response.data!;
        ref.read(localCitiesProvider.notifier).processSelected(data);
      },
    );
  }

  FutureNotifierState<WeatherModel> getLocationForecast() {
    return convert<WeatherModel>(WeatherService.getLocationForecast);
  }
}
