import 'package:renweather/app/shared/shared.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/models/city_location_model.dart';
import '../../data/models/weather_model.dart';

final localCitiesProvider =
    NotifierProvider<PersistedCities, Map<String, (WeatherModel?, LongLatit)>>(
        PersistedCities.new);

class PersistedCities
    extends Notifier<Map<String, (WeatherModel?, LongLatit)>> {
  @override
  Map<String, (WeatherModel?, LongLatit)> build() {
    _loadPersistedCities();
    return {};
  }

  List<String> presentCities = [];
  final List<String> persistedCities = ['Lagos', 'Abuja', 'Ibadan'];

  void _loadPersistedCities() async {
    presentCities =
        Preferences.getListString(key: 'persistedCities') ?? persistedCities;
  }

  void addDataToMap(WeatherModel data) {
    if (state.containsKey(data.name)) {
      final updatedMap = {...state};

      updatedMap[data.name] = (
        data,
        LongLatit(
          latitiude: "${data.coord.lat}",
          long: "${data.coord.lon}",
        ),
      );

      state = updatedMap;
    }
  }

  void _cachePersistedCities() async {
    await Preferences.setListString(
      key: 'persistedCities',
      list: presentCities,
    );
  }

  void processSelected(List<CityLocationModel> data) {
    final updatedMap = {...state};

    for (var item in data) {
      if (presentCities.contains(item.city)) {
        updatedMap[item.city] = (
          null,
          LongLatit(
            latitiude: item.lat,
            long: item.long,
          ),
        );
        if (!presentCities.contains(item.city)) {
          presentCities.add(item.city);
        }
      }
    }

    state = updatedMap;
    _cachePersistedCities();
  }

  void addRemoveCity(String city, LongLatit coordinates) {
    final updatedMap = {...state};

    if (updatedMap.containsKey(city)) {
      updatedMap.remove(city);
      presentCities.remove(city);
    } else {
      updatedMap[city] = (
        null,
        coordinates,
      );
      presentCities.add(city);
    }
    _cachePersistedCities();
    state = updatedMap;
  }
}

class LongLatit {
  final String long;
  final String latitiude;

  const LongLatit({
    required this.latitiude,
    required this.long,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LongLatit &&
        other.long == long &&
        other.latitiude == latitiude;
  }

  @override
  int get hashCode => long.hashCode ^ latitiude.hashCode;
}
