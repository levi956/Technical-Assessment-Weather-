import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:renweather/app/modules/weather/presentation/pages/cities_option_page.dart';
import 'package:renweather/app/modules/weather/presentation/pages/location_forecast_page.dart';
import 'package:renweather/app/shared/shared.dart';

import '../../domain/provider/persisted_locations_provider.dart';

class WeatherHeaderComponent extends HookConsumerWidget {
  final int currentIndex;
  const WeatherHeaderComponent({
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

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () async {
            if (await PermissionService.isRequiredGranted()) {
              if (context.mounted) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const LocationForecastPage();
                }));
              }
              return;
            }
            if (context.mounted) {
              await PermissionService.requestMultiple();
            }
          },
          icon: const PhosphorIcon(
            PhosphorIconsBold.mapPin,
            color: Colors.black,
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const CitiesOptionPage();
              }),
            );
          },
          icon: const PhosphorIcon(
            PhosphorIconsBold.option,
            color: Colors.black,
            size: 30,
          ),
        )
      ],
    );
  }
}

final _now = DateTime.now();
