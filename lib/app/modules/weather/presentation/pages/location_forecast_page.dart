import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:renweather/app/modules/weather/domain/provider/get_location_forecast.dart';
import 'package:renweather/app/shared/shared.dart';
import 'package:renweather/core/framework/base_notifier.dart';

import '../components/atoms/forecast_atom.dart';
import '../components/atoms/weather_info_tile_atom.dart';

class LocationForecastPage extends HookConsumerWidget {
  const LocationForecastPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationForecast = ref.useProvider(getLocationForecastNotifer);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Current location",
        ),
      ),
      body: locationForecast.when(
        done: (forecast) {
          final items = <({
            String title,
            String data,
            IconData icon,
          })>[
            (
              title: "Feels like",
              data: "${forecast.main.feelsLike} °C",
              icon: PhosphorIconsRegular.thermometerSimple,
            ),
            (
              title: "Pressure",
              data: "${forecast.main.pressure} hPa",
              icon: PhosphorIconsRegular.drop,
            ),
            (
              title: "Humidity",
              data: '${forecast.main.humidity} %',
              icon: PhosphorIconsRegular.sun,
            ),
            (
              title: "Sea level",
              data: '${forecast.main.seaLevel} hPa',
              icon: PhosphorIconsRegular.cloudRain,
            ),
            (
              title: "Visibility",
              data: '${forecast.visibility / 1000} km',
              icon: PhosphorIconsRegular.eyes,
            ),
            (
              title: "Wind",
              data: '${forecast.wind.speed} m/s',
              icon: PhosphorIconsRegular.wind,
            ),
          ];

          return ListViewWithStickyFooter(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            children: [
              Text(
                "${forecast.name}, ${forecast.sys.country}",
                style: const TextStyle(
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formatDateTime(_now),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF71797E),
                ),
              ),
              const SizedBox(height: 20),
              WeatherInfoTileAtom(
                model: forecast,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F8FF),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.9,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ForecastAtom(
                      title: item.title,
                      data: item.data,
                      icon: item.icon,
                    );
                  },
                ),
              )
            ],
          );
        },
        error: (error) {
          return Text("$error");
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

final _now = DateTime.now();
