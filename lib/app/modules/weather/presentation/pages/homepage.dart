import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:renweather/app/modules/weather/data/models/get_forecast_model.dart';
import 'package:renweather/app/modules/weather/domain/provider/get_forecast_provider.dart';
import 'package:renweather/app/modules/weather/presentation/components/forecast_tile_component.dart';
import 'package:renweather/app/modules/weather/presentation/components/atoms/pageview_indicator_atom.dart';
import 'package:renweather/app/modules/weather/presentation/components/sunset_sunrise_component.dart';
import 'package:renweather/app/shared/shared.dart';

import '../../domain/provider/persisted_locations_provider.dart';
import '../components/weather_header_component.dart';

class Homepage extends HookConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController(
      viewportFraction: 0.8,
    );

    final pageIndex = useState(0);

    final cityStore = ref.watch(localCitiesProvider);

    //
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(getForecastProvider.notifier).getForecast(
              GetForecastModel(
                latitude: cityStore.entries.first.value.$2.latitiude,
                longitude: cityStore.entries.first.value.$2.long,
              ),
            );
      });
      return () {};
    }, []);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListViewWithStickyFooter(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          children: [
            WeatherHeaderComponent(
              currentIndex: pageIndex.value,
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                itemCount: cityStore.length,
                pageSnapping: false,
                padEnds: false,
                onPageChanged: (index) {
                  final key = cityStore.keys.elementAt(index);
                  final coordinates = cityStore[key]!.$2;
                  final dataModel = cityStore[key]!.$1;

                  pageIndex.value = index;

                  if (dataModel == null) {
                    ref.read(getForecastProvider.notifier).getForecast(
                          GetForecastModel(
                            latitude: coordinates.latitiude,
                            longitude: coordinates.long,
                          ),
                        );
                  }
                },
                itemBuilder: (context, index) {
                  final key = cityStore.keys.elementAt(index);
                  final value = cityStore[key]!;

                  return value.$1 == null
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(
                            right: 20,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6082B6),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${value.$1!.main.temp}°",
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                value.$1?.weather[0].description ?? '',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              LottieBuilder.asset(
                                value.$1!.weather.first.animationIcon,
                                width: 80,
                                height: 80,
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
            const SizedBox(height: 10),
            PageviewIndicator(
              currentIndex: pageIndex.value,
            ),
            const SizedBox(height: 40),
            const Text(
              "Forecast conditions",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ForecastTileComponent(
              currentIndex: pageIndex.value,
            ),
            const SizedBox(height: 30),
            const Text(
              "Time in day",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SunsetSunriseComponent(
              currentIndex: pageIndex.value,
            ),
          ],
        ),
      ),
    );
  }
}
