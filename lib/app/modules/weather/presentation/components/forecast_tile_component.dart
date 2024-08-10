import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../domain/provider/persisted_locations_provider.dart';
import 'atoms/forecast_atom.dart';

class ForecastTileComponent extends HookConsumerWidget {
  final int currentIndex;

  const ForecastTileComponent({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityStore = ref.watch(localCitiesProvider);

    if (currentIndex < 0 || currentIndex >= cityStore.length) {
      return const Center(
        child: Text("Invalid city index"),
      );
    }

    final key = cityStore.keys.elementAt(currentIndex);
    final forecast = cityStore[key]!.$1;

    if (forecast == null) {
      return const Center(
        child: Text("No forecast data available"),
      );
    }

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

    return Container(
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
    );
  }
}
