import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../domain/provider/persisted_locations_provider.dart';
import 'atoms/time_atom.dart';

class SunsetSunriseComponent extends HookConsumerWidget {
  final int currentIndex;
  const SunsetSunriseComponent({
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

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F8FF),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TimeAtom(
            header: "Sunrise",
            icon: PhosphorIconsBold.sun,
            time: forecast.sys.sunriseTime,
          ),
          TimeAtom(
            header: "Sunset",
            icon: PhosphorIconsBold.moon,
            time: forecast.sys.sunsetTime,
          ),
        ],
      ),
    );
  }
}
