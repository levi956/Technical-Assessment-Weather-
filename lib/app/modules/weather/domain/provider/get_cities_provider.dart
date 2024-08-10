import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:renweather/app/modules/weather/data/models/city_location_model.dart';
import 'package:renweather/app/modules/weather/domain/repository/weather_repository.dart';
import 'package:renweather/core/core.dart';

final getCitiesProvider =
    NotifierProvider<GetCitiesNotifier, NotifierState<List<CityLocationModel>>>(
        GetCitiesNotifier.new);

class GetCitiesNotifier extends BaseNotifier<List<CityLocationModel>> {
  @override
  void onInit() {
    _getCities();
    super.onInit();
  }

  Future<void> _getCities() async {
    setLoading();
    state = await ref.read(weatherRepository).getCities();
  }
}
